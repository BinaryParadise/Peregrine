require 'xcodeproj'
require 'yaml'
require 'json'

class PGGenerator

  # 生成路由表
  def self.generator(args)
    project = Xcodeproj::Project.open(ENV['PROJECT_FILE_PATH'])
    current_target = (project.targets.select { |target| target.name == ENV['TARGET_NAME'] }).first

    files = current_target.source_build_phase.files.to_a.map do |pbx_build_file|
        pbx_build_file.file_ref.real_path.to_s
    end

    header_searchs = ENV['HEADER_SEARCH_PATHS'].split(' ')
    include = nil
    if ENV['GCC_PRECOMPILE_PREFIX_HEADER'] == 'YES'
      include = '-include '+ENV['SRCROOT'] + '/' + ENV['GCC_PREFIX_HEADER']
    end
#    -include #{ENV['SHARED_PRECOMPS_DIR']}/11336253693664976894/Header.pch.d \

    shell = "/usr/local/bin/clang-peregrine #{files.join(' ')} \
    -p=\"#{args[0]}\" \
    -- \
    -fmodules -Werror -Wno-implicit-atomic-properties -Wimplicit-function-declaration -fsyntax-only -fobjc-arc -ferror-limit=9999 \
    -Wobjc-missing-super-calls -fobjc-arc \
    -isysroot #{ENV['SDKROOT']} \
    #{include} \
    -I#{header_searchs.join(' -I')} \
    -F#{ENV['DEVELOPER_FRAMEWORKS_DIR']} \
    "
    `#{shell}`
    # installer.analysis_result.targets.each do |target|
    #   files = []
    #   target.pod_targets.each do |pod_target|
    #     pod_target.file_accessors.each do |file_accessor|
    #       file_accessor.source_files.each do |file|
    #         files.push(file.to_path)
    #       end
    #     end
    #   end
    #   puts files.class
    # end
  end

end

PGGenerator::generator(ARGV)
