require 'bundler/gem_helper'

Bundler::GemHelper.install_tasks

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc you must: sudo gem install yard"
  end
end
