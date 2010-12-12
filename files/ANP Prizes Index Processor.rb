#!/usr/bin/ruby

require 'rubygems'
require 'csv'
require 'active_support'
require 'action_view/helpers/text_helper'
include ActionView::Helpers::TextHelper
include ActiveSupport::CoreExtensions



Colors = {  'L' => '#ff0000',
            'R' => '#00a018',
            'RR' => '#00a07c',
            'Z' => '#0006ff',
            'ZZ' => '#a700ff' }

prizes = CSV.read('ANP Prizes Index.csv')
expanded_list = []
# Drop the last row (with the total in it)
prizes.pop
# Drop the first row (with the headers in it)
prizes.shift

prizes.collect do |p|
  # capture and process the description line. remove anything that does not start with a letter
  desc = p[3] #/(?:.*?\b)?([A-Za-z].*)/.match(p[3])[1]
  desc = desc.gsub /\bwith\b/i, "w/"
  desc = desc.gsub /\band|\+\b/i, "&"
  desc = desc.gsub /\bTickets?\b/i, "Tix"
  desc = desc.gsub /\bCoupons?\b/i, "Cpn."
  desc = desc.gsub /\bTimberwolves\b/i, "T-wolves"
  desc = desc.gsub /\bTelevisions?\b/i, "TV"
  desc = desc.gsub /\bProfessional\b/i, "Pro."
  desc = desc.gsub /\bRefrigerators?\b/i, "Fridge"
  desc = desc.gsub /\bCameras?\b/i, "Cam"
#    desc = desc.gsub /\b\b/i, ""
#    desc = desc.gsub /\b\b/i, ""
#    desc = desc.gsub /\b\b/i, ""
  
  # Truncate the description to 30 chars just in case    
  desc = word_wrap(desc.strip, :line_width => 27).split("\n")[0..1].join("\n")

  klass = p[2].upcase
  klass_color = Colors[klass]
  quant = p[1].to_i
  
  quant.times do |i| 
    new_row = ["%03d" % p[0].to_i, i+1, quant, desc, klass, klass_color]
    expanded_list << new_row
    #puts new_row.join ", "
  end
end
prizes = []
expanded_list.group_by{|row| row[4] }.each_value do |set|
 prizes = prizes + set.shuffle 
end

CSV.open("ANP Prizes Index.processed.randomized.csv", 'w') do |csv|
  prizes.each do |row|
    csv << row    
    #puts row.join ", "
  end
end

CSV.open("ANP Prizes Index.processed.csv", 'w') do |csv|
  expanded_list.each do |row|
    csv << row    
    #puts row.join ", "
  end
end

