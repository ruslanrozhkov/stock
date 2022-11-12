require_relative "lib/stock"

checker = Stock::Checker.new
checker.call

puts "Result:\n"
p checker.result

puts "DE Products:\n"
p checker.result.select { |url| url.country.eql?(:de) }

puts "DE Products in stock:\n"
p checker.result.select { |url| url.country.eql?(:de) && url.in_stock }

puts "DE Products out of stock:\n"
p checker.result.select { |url| url.country.eql?(:de) && url.out_of_stock }