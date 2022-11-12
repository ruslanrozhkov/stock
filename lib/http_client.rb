module Stock
  class HttpClient
    def initialize(url, retries = 2)
      @uri = URI(url)
      @retries = retries
    end

    def body
      begin
        Net::HTTP.get(@uri)
      rescue => e
        puts e.message
        @retries -= 1
        retry if retries.positive?
      end
    end
  end
end