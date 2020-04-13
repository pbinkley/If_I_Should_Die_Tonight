#!/usr/bin/env ruby
# frozen_string_literal: true

require 'base64'
require 'csv'
require 'date'
require 'digest/md5'
require 'fileutils'
require 'nokogiri'
require 'pathname'

require 'byebug'

input = ARGV[0]
data = File.open(input) { |f| Nokogiri::HTML(f) }

filepath = Pathname.new(input)
filename = filepath.basename.sub(/#{filepath.extname}$/, '')

count = data.xpath('//span[@id="results-match-count"]')
items = data.xpath('//div[@class = "record-content"][not(div[@class="clip-sr"])]')
clippings = data.xpath('//div[@class = "record-content"][div[@class="clip-sr"]]')
# TODO handle clippings

puts "#{count.text} results; #{items.count} items, #{clippings.count} clippings"

FileUtils.mkdir_p('thumbnails')

CSV.open("#{filename}-pages.csv", 'wb') do |csv|
  csv << %w[id filename publication location date page url]
  items.each_with_index do |item, index|
    # puts index
    # generate image from base64 string
    image_base64 = item.xpath('../div/div/div/a/img/@src').first.to_s
    # strip html context 
    image_base64.sub!('data:image/jpeg;base64,', '')
    image = Base64.decode64(image_base64)
    thumbnail = Digest::MD5.hexdigest(image)
    File.open("thumbnails/#{thumbnail}.jpg", 'wb') do |f|
      f.write(image)
    end

    # process metadata and add to csv output

    row = []
    row << index + 1
    row << thumbnail
    row << item.xpath('./a/h2').first.text # publication title
    row << item.xpath('./a/i[@title="Location"]').first.text # location
    blocks = item.xpath('./a/div/span[@title="Date"]').first.text.split("\n") # date and page
    row << Date.strptime(blocks[0], '%A, %B %e, %Y') # date
    row << ((blocks.count > 1) ? blocks[1].gsub(/[^0-9]/, '').to_i : 0) # page
    row << item.xpath('./a').first.attribute('href').to_s # url
    csv << row
  end
end

puts 'end'
