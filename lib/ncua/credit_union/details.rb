module NCUA
  module CreditUnion
    class Details < Record
      field :credit_union_name
      field :charter_number
      field :credit_union_type
      field(:active?, :credit_union_status) { |value| value == "Active" }
      field(:corporate_credit_union?, :corporate_credit_union) { |value| value == "Yes" }
      field :credit_union_charter_year
      field(:current_charter_issue_date) { |value| Date.strptime(value, '%m/%d/%Y') }
      field(:date_insured) { |value| Date.strptime(value, '%m/%d/%Y') }
      field :charter_state
      field :region
      field :field_of_membership_type
      field(:low_income_designation?, :low_income_designation) { |value| value == "Yes" }
      field(:member_of_fhlb?, :member_of_fhlb) { |value| value == "Yes" }
      field(:assets) { |value| value.gsub(/[$,]/,"").to_f }
      field :peer_group
      field(:number_of_members) { |value| value.gsub(",","").to_i }
      field :address
      field :city_state_zip_code
      field :country
      field :county
      field :phone
      field :website
      field :ceo_or_manager
    end
  end
end
