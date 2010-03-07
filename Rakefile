require 'rubygems'

require 'rake'
require 'spec/rake/spectask'

desc 'Run all specs across all supported Rails gem versions.'
task :spec do
  versions = %w(2.3.4 2.3.5)
  cmd = "cd test_rails_app && " + (versions.map { |version|
    "echo '===== Testing #{version} =====' && RAILS_GEM_VERSION=#{version} rake"
  }.join(" && "))
  puts cmd
  puts `#{cmd}`
end