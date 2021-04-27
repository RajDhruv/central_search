require 'watir'
require 'nokogiri'
require 'open-uri'
class Scrapper
  attr_accessor :item, :browser, :url, :result_hash
  def initialize(item)
    @item = item
    @browser = browser
    @url = page_url
    @result_hash = Hash.new
  end

  def start_process
    search_browser
    scrap_site
  end

  def browser
    @browser ||= Watir::Browser.new
  end

  def search_browser
    browser.goto(url)
    browser.text_field(name: "field-keywords").set(item)
    browser.input(type: 'submit').click
  end

  def scrap_site
    html = open(browser.url)
    html_doc = Nokogiri::HTML(html)
    browser.close
    generate_result_hash(html_doc)
  end

  def generate_result_hash(html_doc)
    html_doc.css('div.s-result-item').each_with_index do |result_row, i|
      result_hash[i.to_s] = attribute_hash(result_row) unless result_row.css('span.a-size-medium').blank?
    end
    result_hash
  end

  def attribute_hash(result_row)
    {image: result_row.css('img.s-image').attribute('src').value,
      name: result_row.css('span.a-size-medium').text,
      price: result_row.css('span.a-price-whole').text
    }
  end

  def page_url
    'https://www.amazon.in/'
  end
end
