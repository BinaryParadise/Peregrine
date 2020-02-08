#!/usr/bin/ruby -W0

require 'xcodeproj'
require 'yaml'
require 'json'
require 'uri'

BUILD_PHASE_NAME_FETCH_ENV = '[Peregrine] Generator Routing Table'
CLANG_TOOL_PATH = '/usr/local/bin/clang-peregrine'
CLANG_MODE = 'Clang'
PG_VERSION = "0.6.6"

class PGGenerator
  attr_accessor:routers
  attr_accessor:version
  def initialize(args)
    if args[0].eql?('install')
      return
    end
    if ENV["GENERATE_MODE"].eql?(CLANG_MODE)
      buildWithClang(args)
    else
      @routers = Array.new
      buildWithRegularExpression(args)      
    end    
  end

  # 通过Clang生成路由表
  def buildWithClang(args)
    project = Xcodeproj::Project.open(ENV['PROJECT_FILE_PATH'])
    current_target = (project.targets.select { |target| target.name == ENV['TARGET_NAME'] }).first

    files = current_target.source_build_phase.files.to_a.map do |pbx_build_file|
        pbx_build_file.file_ref.real_path.to_s
    end
    files = files.select {|file| File.extname(file).eql?(".m")}
    files = files.map do |file|
        "\""+file+"\""
    end

    header_searchs = ENV['HEADER_SEARCH_PATHS'].split(' ')
    include = nil
    if ENV['GCC_PRECOMPILE_PREFIX_HEADER'] == 'YES'
      include = '-include '+ENV['SRCROOT'] + '/' + ENV['GCC_PREFIX_HEADER']
    end
    framework_searchs = ENV['FRAMEWORK_SEARCH_PATHS'].split(' ')

    output = ENV["BUILT_PRODUCTS_DIR"]
    if !ENV["PODS_CONFIGURATION_BUILD_DIR"].nil?
      output = ENV["PODS_CONFIGURATION_BUILD_DIR"]      
    end

    Dir::entries(output).each{|item|(
      if File.extname(item).eql?(".app")
        output = ENV["PODS_CONFIGURATION_BUILD_DIR"] + "/"+item+"/Peregrine.bundle"
      end
    )}

    shell = "#{CLANG_TOOL_PATH} #{files.join(' ')} \
    -p=\"#{output}\" \
    -- \
    -fmodules -Wno-implicit-atomic-properties \
    -Wimplicit-function-declaration -fsyntax-only \
    -fobjc-arc -ferror-limit=0 -w -fmacro-backtrace-limit=0 \
    -Wobjc-missing-super-calls \
    -isysroot #{ENV['SDKROOT']} \
    #{include} \
    -I\"#{ENV['SRCROOT']}\" \
    -I#{header_searchs.join(' -I')} \
    -F#{framework_searchs.join(' -F')} \
    -F#{ENV['DEVELOPER_FRAMEWORKS_DIR']} \
    "
    puts "#{shell}"
    `#{shell}`
    
    routers = JSON.parse(File.read("#{output}/routers.json"))      
    prettify(routers, output)

  end

  # 通过正则表达式匹配生成路由表
  def buildWithRegularExpression(args)
    srcroot = ENV['SRCROOT']
    
    collectPath(srcroot)
    
    # 生成路由表到目标App中
    destination_file = ENV["BUILT_PRODUCTS_DIR"]
    if !ENV["PODS_CONFIGURATION_BUILD_DIR"].nil?
      destination_file = ENV["PODS_CONFIGURATION_BUILD_DIR"]      
    end

    Dir::entries(destination_file).each{|item|(
      if File.extname(item).eql?(".app")
        destination_file = ENV["PODS_CONFIGURATION_BUILD_DIR"] + "/"+item+"/Peregrine.bundle"
      end
    )}
    if !File::exist?(destination_file)
      `mkdir #{destination_file}`
    end    

    prettify(@routers, destination_file)

  end

  # 收集所有.h中声明的路由
  def collectPath(path)
    Dir::entries(path).each {|item| (
      subPath = path+"/"+item
      if File.directory?(subPath)
        if isDirectory(item)
          collectPath(subPath)
        end
      else
        if File.extname(item).eql?('.h')
          mapRouter(subPath)
        end
      end
    )}
  end

  def isDirectory(path)
    if path.eql?('.') || path.eql?('..') || path.eql?('.git') || File.extname(path).length > 0
      return false
    end
    return true
  end

  def mapRouter(file_path)
    file_content = File.read(file_path)
    file_content.scan(/@interface\s+(\w+)\s*[\s\S]+?\n([\s\S]+?)@end/) do |match|
      class_name = match[0]
      class_content = match[1]
      class_content.scan(/PG\w*Method\((\b\w+\b),\s*\"([\s\S]+?)\"\);/) do |match1|
        @routers.push({ 'class' => class_name, 'selector' => match1[0] + ':', 'url' => match1[1] })
      end
    end
  end

  # 路由表格式化为指定结构
  def prettify(routers, destination_file)
    if routers.class != Array
      return
    end
    routerMap = Hash.new
    routers.each {|item| (
      routerURL = URI(URI::encode(item['url']))
      group = "#{routerURL.scheme}://#{routerURL.host}"
      rootNode = routerMap[group]
      if rootNode.nil?
        rootNode = Array.new
        routerMap[group] = rootNode
      end
      rootNode.push(item)
    )}

    router_json_file = File.new("#{destination_file}/routers.json", 'w+')
    router_json_file.write(JSON.pretty_generate(routerMap))
    router_json_file.close
    puts "🍺router write to #{router_json_file.path}"

    generate_header_file(routerMap)
    generate_header_file(routerMap, false)

  end

  def generate_header_file(routerMap, header=true)
    # 更新路由的定义头文件
    ext = header ? '.h' : '.m'
    path = "#{File.dirname(__FILE__)}/PGRouter+Generate#{ext}"
    `chmod 755 #{path}`
    generate_file = File.new(path, 'w+')
    generate_file.write("//
//  PGRouter+Generate.#{ext}
//  Peregrine
//
//  Created by Rake Yang on 2019/12/31.
//  Copyright © 2019 BinaryParadise. All rights reserved.

")

  if header
    generate_file.write("/**
  Generated automatic by Peregrine version #{ENV['PG_VERSION']} 
  Don't modify manual ⚠️
*/
  
/// Build Time #{Time.now}

typedef NSString *PGRouterURLKey;
")
  else
    generate_file.write("#import \"PGRouter+Generate.h\"
    ")
  end

    routerMap.each {|key, value| (
      generate_file.write("
#pragma - mark #{key.split('//').last}

")
      sorted = value.sort {|a, b| a['url'] <=> b['url'] }
      sorted.each {|item| (
        uri = URI(URI::encode(item['url']))
        if header
          generate_file.write("/// #{item['url']}\n")
          generate_file.write("FOUNDATION_EXPORT PGRouterURLKey const #{uri.scheme}_#{uri.host}#{uri.path.split('/').join('_')};\n\n")
        else
          generate_file.write("\nPGRouterURLKey const #{uri.scheme}_#{uri.host}#{uri.path.split('/').join('_')} = @\"#{item['url']}\";\n")
        end
      )}
    )}
    generate_file.close

    puts "🍺Objective-C header file write to #{generate_file.path}"
  end

  # expression=true表示使用正则匹配模式 
  def self.configure_project(installer, expression=true, condition=nil)
    path = installer.sandbox.development_pods['Peregrine']    
    @ruby_path = path ? path.dirname.to_s : "${PODS_ROOT}/Peregrine"

    installer.analysis_result.targets.each do |target|
      if target.user_project_path.exist? && target.user_target_uuids.any?
        project = Xcodeproj::Project.open(target.user_project_path)
        project_targets = self.project_targets(project, target)
        self.add_shell_script(project_targets, project, expression)
      end

    end

    # 处理Pod的路由生成脚本
    installer.pod_targets.each do |target|
        if !condition.nil? && condition.call(target.pod_name)
          project_path = installer.sandbox.root.to_s+"/"+target.pod_name+".xcodeproj"
          if File::exist?("#{project_path}/project.pbxproj")
            project = Xcodeproj::Project.open(project_path)
            self.add_shell_script(project.targets, project, expression)
          end
        end
    end

  end

  def self.add_shell_script(project_targets, project, expression=true)
    install_targets = project_targets.select { |target| ['com.apple.product-type.application','com.apple.product-type.framework'].include?(target.product_type) }
    install_targets.each do |project_target|
      phase = self.fetch_exist_phase(BUILD_PHASE_NAME_FETCH_ENV, project_target)
      if phase.nil?
          phase = project_target.new_shell_script_build_phase(BUILD_PHASE_NAME_FETCH_ENV)
          if expression
            # 插入到源码之前
            project_target.build_phases.delete(phase)
            source_index = project_target.build_phases.index(project_target.source_build_phase)
            project_target.build_phases.insert(source_index, phase)
          end
      else
        if false
            phase.remove_from_project()
        end
      end

      mode = nil
      if !expression
        mode = "export GENERATE_MODE=#{CLANG_MODE}"
      end

      pg_version = PG_VERSION
      if File::exist?("#{Dir.pwd}/Podfile.lock")
        file_content = File.read("#{Dir.pwd}/Podfile.lock")
        file_content.scan(/(Peregrine\s\()(\d.+)(\))/) do |match|
          pg_version = match[1]
          break
        end
      end

      phase.shell_script = "export LANG=en_US.UTF-8 export LANGUAGE=en_US.UTF-8 export LC_ALL=en_US.UTF-8 export PG_VERSION=#{pg_version} #{mode}
ruby #{@ruby_path}/Peregrine/PGGenerator.rb"

      project.save()
    end

  end

  def self.project_targets(project, target)
    project_targets = Array.new

    target.user_target_uuids.each do |user_target_uuid|
      project.targets.each do |project_target|
        if project_target.uuid.eql? user_target_uuid
          project_targets.push(project_target)
        end
      end
    end

    return project_targets
  end

  #判断是否已存在
  def self.fetch_exist_phase(phase_name, project_target)
    project_target.build_phases.each do |build_phase|
      next if build_phase.display_name != phase_name
      #build_phase.remove_from_project
      return build_phase
    end
    return nil
  end

end

PGGenerator::new(ARGV)
