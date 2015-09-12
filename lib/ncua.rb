require 'httparty'
require 'nokogiri'
require 'ncua/version'
require 'ncua/client'
require 'ncua/credit_union/record'
require 'ncua/credit_union/office'
require 'ncua/credit_union/scraper'

module NCUA
  def self.find_office_by_address(address, opts={radius: 100})
    resp = Client.new.find_credit_union_by_address(address, opts[:radius])
    resp["list"].map { |result| CreditUnion::Office.new(result) }
  end

  def self.find_office_by_name(name)
    resp = Client.new.find_credit_union_by_name(name)
    resp["list"].map { |result| CreditUnion::Office.new(result) }
  end

  def self.find_office_by_charter_number(charter_number)
    resp = Client.new.find_credit_union_by_charter_number(charter_number)
    resp["list"].map { |result| CreditUnion::Office.new(result) }
  end
end
