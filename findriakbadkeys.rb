#!/usr/bin/ruby -W0
require 'riak'
require 'json'
require 'highline/import'
client = Riak::Client.new
DELETE = true
LIMIT = 1000000

buckets = %w( bucket )

buckets.each do |bucket|
  puts "Processing bucket #{bucket}"
  client[bucket].keys.each do |key, value|

    if !key.force_encoding("UTF-8").valid_encoding?
      puts "Offending KEY is '#{key}' in #{bucket}, enc: '#{key.encoding}', asc: '#{key.ascii_only?}' \n"
      if DELETE
         puts "Deleting key #{client[bucket][key]} #{key}"
         confirm = ask("Do it? [Y/N] ") { |yn| yn.limit = 1, yn.validate = /[yn]/i }
         if confirm.downcase == 'y' then
           client[bucket][key].delete
         end
      end
    end

   keysize = client[bucket][key].raw_data.size 
   if keysize > LIMIT
        puts "Found key more then #{LIMIT} bytes: '#{key}' bucket #{bucket} size is #{keysize}"
   end

  end
end
