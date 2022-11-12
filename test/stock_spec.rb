require "minitest/autorun"
require_relative "../lib/stock"

describe Stock::HttpClient, :body do
  before do
    @client = Stock::HttpClient.new("http://test.com")
  end

  describe "when response successful" do
    it "returns response body" do
      Net::HTTP.stub(:get, "<html>body</html>") do
        assert_equal @client.body, "<html>body</html>"
      end
    end
  end
end

describe Stock::Parser, :in_stock? do
  before do
    @parser = Stock::Parser.new("http://test.com")
  end

  describe "when parser not defined" do
    it "raise error" do
      assert_raises RuntimeError do
        Net::HTTP.stub(:get, "<html>body</html>") do
          @parser.in_stock?
        end
      end
    end
  end
end

describe Stock::DeParser, :in_stock? do
  before do
    @parser = Stock::DeParser.new("http://test.com")
  end

  it "product in stock" do
    Net::HTTP.stub(:get, "<span id='addToCart'>In den Warenkorb</span>") do
      assert @parser.in_stock?
    end
  end

  it "product out of stock" do
    Net::HTTP.stub(:get, "<span id='addToCart'>Derzeit ausverkauft</span>") do
      refute @parser.in_stock?
    end
  end
end

describe Stock::Checker, :call do
  before do
    @checker = Stock::Checker.new
  end

  describe "when list of urls passed" do
    it "returns array of urls" do
      Net::HTTP.stub(:get, "<span id='addToCart'>In den Warenkorb</span>") do
        _(@checker.call) do
          assert_instance_of Stock::Url, @checker.result.first
        end
      end
    end
  end
end