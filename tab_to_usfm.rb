#!/usr/bin/env ruby

require 'csv'

Dir.glob("**/*.tsv") do |file|
  ch = []
  hash = {}
  nc = {}
  v = {}
  h = Hash.new { |hash, key| hash[key] = [] }
  count=0
  begin
    CSV.foreach("#{file}", {:col_sep => "\t", :quote_char => "^"}) do |row|
      edited_v = row[1]? row[3].gsub(/\bp\b/i,"\n\n\\p\n") : ""
      edited_v = edited_v != ""? edited_v.gsub("[", "\\q ") : ""
      edited_v = edited_v != ""? edited_v.gsub("]", "") : ""
      edited_v = edited_v != ""? edited_v.gsub(/ {2,}/, " ") : ""
      sec_text = row[4]? "\\s #{row[4]}\n" : ""
      sec_text = sec_text != ""? sec_text.gsub(/ {2,}/, " ") : ""
      h[:"#{row[1]}"] << sec_text+"\\v "+row[2].to_s+" "+edited_v
      hash.store(row[0], h)
      count = count + 1
    end
  rescue Exception => e
    puts "#{file} file is not complete OR has missing data"
  end

  directory_name = "output_folder"
  Dir.mkdir(directory_name) unless File.exists?(directory_name)

  output_name = "#{directory_name}/#{File.basename(file, '.*')}.usfm"
  output = File.open(output_name, 'w')

  hash.each do |k, v|
    output << "\\id #{k}\n"
    v.each do |k, v|
      output << "\\c #{k}\n"
      v.each do |k, v|
        output << "#{k}\n"
      end
    end
  end
  output.close
end
