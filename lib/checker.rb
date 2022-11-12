module Stock
	# Stock checker service
	class Checker
		attr_reader :list_of_urls, :result

		def initialize(list_of_urls = LIST_OF_URLS, parallel: false)
			@list_of_urls = list_of_urls
			@parallel			= parallel
			@result 			= []
		end

		def call
			@parallel ? check_urls_concurrently : check_urls
		end

		private

		def check_urls
			@list_of_urls.each do |country, urls|
				urls.each { |url| @result << create_url(country, url) }
			end
		end

		def check_urls_concurrently
			@list_of_urls.each do |country, urls|
				urls.each { |url| Thread.new { @result << create_url(country, url) } }
			end
		end

		def create_url(country, url)
			Url.new(url, country, item_in_stock?(country, url))
		end

		def item_in_stock?(country, url)
			Stock.parsers[country].new(url).in_stock?
		end
	end
end