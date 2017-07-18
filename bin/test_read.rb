require "net/http"
require "uri"
require "json"
require "benchmark"
require "byebug"

def test(url)
  5.times do |i|
    puts "run ##{i+1}"
    `bin/rails db:seed`
    counters = []
    threads = []

    5.times do |j|
      # remember to tweak puma and db config for this to make sense (eg. pool, workers, threads)
      threads << Thread.new do
        uri = URI.parse(url)
        req = Net::HTTP::Get.new(uri.to_s)
        res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
        print "."
        counter = res.body.to_i
      end
    end

    threads.each do |thr|
      counters << thr.join.value
    end

    puts
    puts counters.join(" ")
    puts counters.uniq.size
    puts
  end
end

puts "Not safe"
puts "========"
test("http://localhost:3000/read/not_safe")

puts "Safe"
puts "========"
test("http://localhost:3000/read/safe")
