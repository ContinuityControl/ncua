# Ncua

The NCUA [lets you search for a credit union office](http://www.ncua.gov/NCUAMapping/Pages/NCUAGOVMapping.aspx) by name, address and charter number. Their site uses a JSON api behind their

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

The NCUA lets you find a Credit Union office by its name, charter number, or within an address:

```ruby
  credit_unions = NCUA.find_by_name('Federal')  #=> [NCUA::CreditUnion, ... ]
```

You can `find_by` `name`, `address`, `charter_number`. Searching by address takes an optional radius argument to limit the scope of the address query (units are in miles):
```ruby
  credit_unions = NCUA.find_by_charter_number(12345)  #=> [NCUA::CreditUnion, ... ]

  credit_unions = NCUA.find_by_address("125 Main St., Anywhere, CT", radius: 50)  #=> [NCUA::CreditUnion, ... ]
```

Right now, an `NCUA::CreditUnion` has all of the following getters:

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ContinuityControl/ncua.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
