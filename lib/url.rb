module Stock
  # Output data structure
  # url = Stock::Url.new("link.com", :de, true)
  Url = Struct.new(:url, :country, :in_stock) do
    def out_of_stock
      !in_stock
    end
  end
end