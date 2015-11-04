namespace :ncua do
  desc "Verify Schema"
  task(:validate_schema!) do
    ::NCUA.validate_schema!
  end
end
