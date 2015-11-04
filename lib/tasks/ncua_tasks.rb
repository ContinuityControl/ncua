module NCUA
  class NCUATasks
    include Rake::DSL if defined? Rake::DSL
    def install_tasks
      namespace :ncua do
        desc "Verify Schema"
        task(:validate_schema!) do
          ::NCUA.validate_schema!
        end
      end
    end
  end
end
