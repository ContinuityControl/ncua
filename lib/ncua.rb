require 'httparty'
require 'nokogiri'
require 'ncua/version'
require 'ncua/client'
require 'ncua/client_validator'
require 'ncua/credit_union/record'
require 'ncua/credit_union/office'
require 'ncua/credit_union/details'
require 'ncua/credit_union/scraper'
require 'ncua/credit_union/scraper_validator'
require 'ncua/credit_union/details_client'

module NCUA
  require "ncua/railtie" if defined?(Rails)

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

  def self.find_credit_union(charter_number)
    CreditUnion::Details.new(CreditUnion::Scraper.new(charter_number).scrape!)
  end

  def self.validate_schema!
    unless NCUA::CreditUnion::ScraperValidator.new.schema_valid?
      raise "NCUA CreditUnion Scraper Schema is invalid. Please contact Gem Maintainer"
    end

    unless NCUA::ClientValidator.schema_valid?
      raise "NCUA Client Schema is invalid. Please contact Gem Maintainer"
    end

    true
  end

  def self.schema_valid?
    NCUA::CreditUnion::Scraper.new(42).schema_valid? && NCUA::ClientValidator.schema_valid?
  end
end
