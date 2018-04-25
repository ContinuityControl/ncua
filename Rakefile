require "bundler/gem_tasks"
require "rspec/core/rake_task"
require './lib/tasks/ncua_tasks'
require 'ncua'


RSpec::Core::RakeTask.new(:spec)

task :default => :spec
Bundler::GemHelper.install_tasks
NCUA::NCUATasks.new.install_tasks
