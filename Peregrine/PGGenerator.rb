require 'xcodeproj'
require 'yaml'
require 'json'

BUILD_PHASE_NAME_FETCH_ENV = '[Peregrine] Generator Routing Table'
CLANG_TOOL_PATH = '/usr/local/bin/clang-peregrine'

class PGGenerator
  # 生成路由表
  def self.generator(args)
    if !ENV["ACTION"].eql?("build")
      return
    end
    puts args[0]
    if args[0] == 1 || args[0].nil?
        if !File::exist?(CLANG_TOOL_PATH)
          raise "Peregrine not install
要安装请执行以下命令:
brew tap binaryparadise/formula
brew install peregrine"
          return
        end
    end
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

    puts "router path: #{output}"
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
  end
  # required=true表示未安装peregrine的clang插件时会编译失败（防止路由表未生成） 
  def self.configure_project(installer, required=true, condition=nil)
    path = installer.sandbox.development_pods['Peregrine']
    @dev_path = path ? path.dirname.to_s : nil

    installer.analysis_result.targets.each do |target|
      if target.user_project_path.exist? && target.user_target_uuids.any?
        project = Xcodeproj::Project.open(target.user_project_path)
        project_targets = self.project_targets(project, target)
        self.add_shell_script(project_targets, project, required)
      end

    end

    # 处理Pod的路由生成脚本
    installer.pod_targets.each do |target|
        if !condition.nil? && condition.call(target.pod_name)
          project = Xcodeproj::Project.open(installer.sandbox.root.to_s+"/"+target.pod_name+".xcodeproj")
          self.add_shell_script(project.targets, project)
        end
    end

  end

  def self.add_shell_script(project_targets, project, required=true)
    install_targets = project_targets.select { |target| ['com.apple.product-type.application','com.apple.product-type.framework'].include?(target.product_type) }
    install_targets.each do |project_target|
      rubypath = (@dev_path == nil ?  "${PODS_ROOT}/Peregrine" : @dev_path) + "/Peregrine/PGGenerator.rb"

      phase = self.fetch_exist_phase(BUILD_PHASE_NAME_FETCH_ENV, project_target)
      if phase.nil?
        phase = project_target.new_shell_script_build_phase(BUILD_PHASE_NAME_FETCH_ENV)
      else
        if false
            phase.remove_from_project()
        end
      end

      clang_reqired = 0
      if required
        clang_reqired = 1
      end

      phase.run_only_for_deployment_postprocessing = "0"
      phase.shell_script = "export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
ruby #{rubypath} #{clang_reqired}"

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

PGGenerator::generator(ARGV)
