#!/usr/bin/env ruby

require 'csv'
Dir.glob("**/*.txt") do |file|
  file_name = file
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

  directory_name = "output_folder"
  Dir.mkdir(directory_name) unless File.exists?(directory_name)

  output_name = "#{directory_name}/#{File.basename(file_name, '.*')}.usfm"
  output = File.open(output_name, 'w')

  hash.each do|k, v|
    output << "\\id #{k}\n"
    v.each do |k, v|
      output << "\\c #{k}\n"
      v.each do |k, v|
        output << "\\v #{k}\n"
      end
    end
  end
  output.close
end
