module Stock
  class Parser
    def initialize(url)
      @url = url
    end

    def in_stock?
      !!(found_text.match(/#{match_text}/))
    end

    private

    def found_text
      html_content.xpath(xpath_selector).text
    end

    def html_content
      Nokogiri::HTML(response_body)
    end

    def response_body
      HttpClient.new(@url).body
    end

    # define xpath selector
    # example: '//*[@id="addToCart"]'
    def xpath_selector
      raise "Please define xpath selector"
    end

    # define match text
    # ex: "Add to cart"
    def match_text
      raise "Plese define match text"
    end
  end
end