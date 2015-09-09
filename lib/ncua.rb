require 'httparty'
require 'ncua/version'
require 'ncua/client'
require 'ncua/record'
require 'ncua/credit_union'

module NCUA
  def self.find_by_address(address, opts={radius: 100})
    resp = Client.new.find_credit_union_by_address(address, opts[:radius])
    resp["list"].map { |result| CreditUnion.new(result) }
  end

  def self.find_by_name(name)
    resp = Client.new.find_credit_union_by_name(name)
    resp["list"].map { |result| CreditUnion.new(result) }
  end

  def self.find_by_charter_number(charter_number)
    resp = Client.new.find_credit_union_by_charter_number(charter_number)
    resp["list"].map { |result| CreditUnion.new(result) }
  end
end
