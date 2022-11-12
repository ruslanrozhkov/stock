module Stock
  class UkParser < Parser
    def xpath_selector
      '//*[@id="buy-btn-product-detail"]'
    end

    def match_text
      "Add to cart"
    end
  end
end