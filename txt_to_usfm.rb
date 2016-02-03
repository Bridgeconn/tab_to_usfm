#!/usr/bin/env ruby

file_name = ARGV[0]
require 'csv'

ch = []
hash = {}
c = {}
v = {}
h = Hash.new { |hash, key| hash[key] = [] }
count=0
CSV.foreach("#{file_name}", {:col_sep => "\t"}) do |row|
  h[:"#{row[1]}"] << row[2].to_s+" "+row[3]
  hash.store(row[0], h)
  count = count + 1
end
file_name = "output_file"
output_name = "#{File.basename(file_name, '.*')}.usfm"
output = File.open(output_name, 'w')

hash.each do|k, v|
  output << "\\id #{k}\n\n"
  v.each do |k, v|
    output << "\\c #{k}\n\n"
    v.each do |k, v|
      output << "\\v #{k}\n\n"
    end
  end
end
output.close


