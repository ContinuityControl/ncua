[![Code Climate](https://codeclimate.com/github/ContinuityControl/ncua/badges/gpa.svg)](https://codeclimate.com/github/ContinuityControl/ncua)
[![Test Coverage](https://codeclimate.com/github/ContinuityControl/ncua/badges/coverage.svg)](https://codeclimate.com/github/ContinuityControl/ncua/coverage)
[![Build Status](https://travis-ci.org/ContinuityControl/ncua.svg)](https://travis-ci.org/ContinuityControl/ncua)
[![Gem Version](https://badge.fury.io/rb/ncua.svg)](http://badge.fury.io/rb/ncua)
# Ncua

The NCUA [lets you search for a credit union office](http://www.ncua.gov/NCUAMapping/Pages/NCUAGOVMapping.aspx) by name, address and charter number. Their site uses a JSON api behind their pages, to serve the data.

This gem is a ruby client to that API. It's totally unaffiliated with the NCUA.
It's open source, so anyone can use it, and anyone can help maintain it. At
this point, it's maintained by [the
developers](http://engineering.continuity.net/) at
[Continuity](http://continuity.net).

## Installation

Add this line to your application's Gemfile:

```ruby
  gem 'ncua'
```

And then execute:
```
  $ bundle
```
Or install it yourself as:
```
  $ gem install ncua
```
## Usage

Currently all of our features are namespaced under the `NCUA` module.

The NCUA lets you find a Credit Union Office by its name, charter number, or within an address:

```ruby
  credit_unions = NCUA.find_office_by_name('Federal')  #=> [NCUA::CreditUnion::Office, ... ]
```

You can also find an office by `name`, `address`, `charter_number`. Searching by address takes an optional radius argument to limit the scope of the address query (units are in miles):
```ruby
  credit_unions = NCUA.find_office_by_charter_number(12345)  #=> [NCUA::CreditUnion::Office, ... ]

  credit_unions = NCUA.find_office_by_address("125 Main St., Anywhere, CT", radius: 50)  #=> [NCUA::CreditUnion::Office, ... ]
```

Right now, an `NCUA::CreditUnion::Office` has all of the following getters:

 ```
 | --------------------------- | ------------------------------------------------------------- |
 | Method                      | Explanation                                                   |
 | --------------------------- | ------------------------------------------------------------- |
 | name                        | The Credit Union's Name                                       |
 | long                        | The Longitude of the Credit Union                             |
 | lat                         | The Latitude of the Credit Union                              |
 | site_name                   | The name of the Credit Union office or branch                 |
 | charter_number              | The Credit Union's Charter Number                             |
 | city                        | The Credit Union's City                                       |
 | country                     | The Credit Union's Country                                    |
 | main_office?                | Whether the Credit Union office is the Main Office            |
 | phone                       | The Credit Union's phone number                               |
 | site_functions              | The Credit Union's Site functions.*                           |
 | site_id                     | The Credit Union's Site ID                                    |
 | state                       | The Credit Union's State                                      |
 | url                         | The Credit Union's Url                                        |
 | zip                         | The Credit Union's Zip Code                                   |
 | distance_from_query_address | The Distance between the queried address and the Credit Union |
 | street                      | The Credit Union's Street address                             |
 | --------------------------- | ------------------------------------------------------------- |

*Currently these are limited to `Member Services`, `Drive Through` and `ATM`
```

`NCUA::CreditUnion::Office` also exposes a `#details` method. This scrapes the NCUA's show page for a particular credit union, and returns an `NCUA::CreditUnion::Details` object. This object contains the details of a particular Credit Union, instead of a particular office location.

Keep in mind, this _scrapes_ data from html, so this might break regularly.

Right now, an `NCUA::CreditUnion::Details` object has the following getters:
```
        | field                      | description                                                                                                  |
        | -------------------------- | ------------------------------------------------------------------------------------------------------------ |
        | credit_union_name          | The Credit Union's name                                                                                      |
        | charter_number             | The Credit Union's NCUA charter number                                                                       |
        | credit_union_type          | The Type of Credit Union (Either Federal Credit Union [FCU] or Federally Insured State Credit Union [FISCU]) |
        | active?                    | Whether the Credit Union is active or not                                                                    |
        | corporate_credit_union?    | Whether the Credit Union is a corporate credit union or not                                                  |
        | credit_union_charter_year  | The year the Credit Union was chartered                                                                      |
        | current_charter_issue_date | The date the current charter was issued                                                                      |
        | date_insured               | The date that the Credit Union was insured as of                                                             |
        | charter_state              | The charter state of the Credit Union                                                                        |
        | region                     | The Credit Union's region                                                                                    |
        | field_of_membership_type   | The Credit Union's field of membership type                                                                  |
        | low_income_designation?    | Whether the Credit Union has low income designation                                                          |
        | member_of_fhlb?            | Whether the Credit Union is a member of the Federal Home Loan Bank System                                    |
        | assets                     | The total assets of the Credit Union, as a floating point decimal                                            |
        | peer_group                 | The Credit Union's Peer Group                                                                                |
        | number_of_members          | The Credit Union's number of Members                                                                         |
        | address                    | The street address of the Credit Union                                                                       |
        | city_state_zip_code        | The City, State and Zip code of the Credit Union                                                             |
        | country                    | The Country of the Credit Union                                                                              |
        | county                     | The County of the Credit Union                                                                               |
        | phone                      | The Phone number of the Credit Union                                                                         |
        | website                    | The Website of the Credit Union                                                                              |
        | ceo_or_manager             | The name of the CEO or Manager of the Credit Union                                                           |
        | -------------------------- | ------------------------------------------------------------------------------------------------------------ |
```

You can also scrape this directly from the NCUA module by calling `NCUA.find_credit_union(charter_number)`

If you pass `nil` into this method, it will raise an `ArgumentError`. The NCUA will actually return a 200 without a charter number, but the data on the page is blank.

If you pass a non-numeric argument, such as `"foo"` into this method, it will also raise an `ArgumentError`.

If for some reason the NCUA returns a 500 error when directly scraping for credit union details, the gem will raise `NCUA::CreditUnion::ServerError`. This can happen if your charter number is invalid.

In fact, we only really expect response codes in the 200 range. If the NCUA returns another response, the gem will raise `NCUA::CreditUnion::ServerError` with the response code in the description.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ContinuityControl/ncua.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
