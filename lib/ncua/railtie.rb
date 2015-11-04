require 'ncua'
require 'rails'
module NCUA
  class Railtie < Rails::Railtie
    rake_tasks do
      NCUA::NCUATasks.new.install_tasks
    end
  end
end
