require 'nokogiri'
require 'net/http'
require_relative 'url'
require_relative 'parser'
require_relative 'checker'
require_relative 'de_parser'
require_relative 'uk_parser'
require_relative 'http_client'

module Stock
  # Hardcoded lis of urls
  LIST_OF_URLS = {
    de: ['https://www.foodspring.de/vegan-protein-cookie-12er-paket', 'https://www.foodspring.de/proteinbrot'],
    uk: ['https://www.foodspring.co.uk/organic-coconut-chips-6-pack', 'https://www.foodspring.co.uk/extra-chocolate-protein-bar-mix-12-pack']
  }

  def self.parsers
    {
      de: Stock::DeParser,
      uk: Stock::UkParser
    }
  end
end