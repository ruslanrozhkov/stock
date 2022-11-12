module Stock
  class DeParser < Parser
    def xpath_selector
      '//*[@id="addToCart"]'
    end

    def match_text
      "In den Warenkorb"
    end
  end
end