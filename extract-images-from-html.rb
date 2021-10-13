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

text = File.read(input)

data = Nokogiri::HTML(text)

filepath = Pathname.new(input)
filename = filepath.basename.sub(/#{filepath.extname}$/, '')

images = data.xpath('//img/@src')

images.each_with_index do |image, index|
    puts "#{index + 1} of #{images.count}"
    # generate image from base64 string
    image_base64 = image.to_s

    imageType = image_base64.match(/data:image\/(.+?)\;/)[1]
    
    # strip html context 
    image_base64.sub!("data:image/#{imageType};base64,", '')
    image_binary = Base64.decode64(image_base64)
    imagefile = "#{'%04d' % (index + 1)}.#{imageType}"
    File.open("test/#{imagefile}", 'wb') do |f|
      f.write(image_binary)
    end

end

puts 'end'
