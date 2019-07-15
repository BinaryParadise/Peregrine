require 'xcodeproj'
require 'yaml'
require 'json'

class PGGenerator

  # 生成路由表
  def self.generator(args)
    project_path = args[0]
    project = Xcodeproj::Project.open(project_path)
    current_target = (project.targets.select { |target| target.name == args[1] }).first
    files = current_target.source_build_phase.files.to_a.map do |pbx_build_file|
        pbx_build_file.file_ref.real_path.to_s
    end

    shell = "~/Github/llvm_dev/Debug/bin/clang-peregrine #{files.join(' ')} -- -fmodules \
    -isysroot #{args[3]} \
    #{args[4]} \
    "
    puts shell
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
