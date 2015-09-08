require 'httparty'
require 'ncua/version'
require 'ncua/exceptions'
require 'ncua/client'
require 'ncua/arg_parser'
require 'ncua/record'
require 'ncua/credit_union'

module NCUA
  def self.find_by(opts = {})
    resp = ArgParser.parse(opts)
    resp["list"].map { |result| CreditUnion.new(result) }
  end
end
