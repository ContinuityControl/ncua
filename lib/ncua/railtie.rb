require 'ncua'
require 'rails'
module NCUA
  class Railtie < Rails::Railtie
    rake_tasks do
      import "#{Gem::Specification.find_by_name('ncua').gem_dir}/lib/tasks/ncua.rake"
    end
  end
end
