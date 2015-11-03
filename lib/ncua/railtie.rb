require 'ncua'
require 'rails'
module NCUA
  class Railtie < Rails::Railtie
    rake_tasks do
      namespace :ncua do
        desc "Verify Schema"
        task(:verify_schema) do
          unless NCUA::CreditUnion::Scraper.schema_valid?
            raise "NCUA CreditUnion Scraper Schema is invalid. Please contact Gem Maintainer"
          end

          unless NCUA::Client.schema_valid?
            raise "NCUA Client Schema is invalid. Please contact Gem Maintainer"
          end
        end
      end

    end
  end
end
