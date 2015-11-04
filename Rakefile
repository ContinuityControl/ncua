require "bundler/gem_tasks"
require "rspec/core/rake_task"

import 'lib/tasks/ncua.rake'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
Bundler::GemHelper.install_tasks
