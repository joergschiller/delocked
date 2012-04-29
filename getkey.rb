#!/usr/bin/env ruby

require "optparse"

options = Hash.new ""
options[:encrypted_size] = 4096

OptionParser.new do |opts|
  opts.banner = "Usage: #{opts.program_name} --original original_file --locked locked_file"
  opts.on("-o", "--original FILE", "Original file") { |v| options[:original] = v }
  opts.on("-l", "--locked FILE", "Locked file") { |v| options[:locked] = v }
  opts.on("-k", "--key FILE", "Output file for key") { |v| options[:key] = v }
end.parse!

[:original, :locked, :key].each { |a| raise OptionParser::MissingArgument.new a if options[a].empty? }

original = File.open(options[:original])
locked = File.open(options[:locked])

raise "Locked and original file are not of same size." unless original.size == locked.size
raise "File is too small." if original.size < options[:encrypted_size]

begin
  key = original.read(options[:encrypted_size]).bytes.map { |byte| byte ^ locked.readbyte }
rescue EOFError
  raise "Locked file is to small."
end

File.open(options[:key], "wb") { |f| f.write key.pack "C*" }

