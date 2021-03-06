#!/usr/bin/env ruby

require 'csv'

file = ARGV[0]
ch = []
hash = {}
c = {}
v = {}
h = Hash.new { |hash, key| hash[key] = [] }
count=0
CSV.foreach("#{file}", {:col_sep => "\t", :quote_char => "^"}) do |row|
  h[:"#{row[1]}"] << row[2].to_s+" "+row[3]
  if count == 1
    row
  end
  hash.store(row[0], h)
  count = count + 1
end

output_name = "#{File.basename(file, '.*')}.usfm"
output = File.open(output_name, 'w')

hash.each do |k, v|
  output << "\\id #{k}\n"
  v.each do |k, v|
    output << "\\c #{k}\n"
    v.each do |k, v|
      output << "\\v #{k}\n"
    end
  end
end
output.close
