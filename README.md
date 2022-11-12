# Stock Checker Service

The service that checks whether a product of an eCommerce shop is in stock or out of stock.

Then script calls the URL and reads out the text of the “Add to Cart” button and compares to the correct text. 
E.g. for the German site it will say "In den Warenkorb" if the product is in stock. 
So if that is not the case, we know the product is out of stock.

## Usage

Service accept the list of urls as hash where key is country code and value is array of urls:

```
require_relative "lib/stock"

list_of_urls = {
	de: ['https://www.foodspring.de/vegan-protein-cookie-12er-paket', 'https://www.foodspring.de/proteinbrot'],
	uk: ['https://www.foodspring.co.uk/organic-coconut-chips-6-pack', 'https://www.foodspring.co.uk/extra-chocolate-protein-bar-mix-12-pack']
}

checker = Stock::Checker.new(list_of_urls)
checker.call

checker.result
 => [#<struct Stock::Url url="https://www.foodspring.de/proteinbrot", country=:de, in_stock=false>, #<struct Stock::Url url="https://www.foodspring.de/vegan-protein-cookie-12er-paket", country=:de, in_stock=true>, #<struct Stock::Url url="https://www.foodspring.co.uk/extra-chocolate-protein-bar-mix-12-pack", country=:uk, in_stock=false>, #<struct Stock::Url url="https://www.foodspring.co.uk/organic-coconut-chips-6-pack", country=:uk, in_stock=false>]


```

###### Ouput data structure

Is an array with Struct objects which can be easly sorted by country or availability (in stock/out of stock).

```
checker = Stock::Checker.new(list_of_urls)
checker.call

# urls sorted by country
checker.result.select { |url| url.country.eql?(:de) }

# urls sorted by country and availability
checker.result.select { |url| url.country.eql?(:de) && url.in_stock }
 => [#<struct Stock::Url url="https://www.foodspring.de/vegan-protein-cookie-12er-paket", country=:de, in_stock=true>]

checker.result.select { |url| url.country.eql?(:de) && url.out_of_stock }
 => [#<struct Stock::Url url="https://www.foodspring.de/proteinbrot", country=:de, in_stock=false>]
```