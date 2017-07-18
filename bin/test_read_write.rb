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

    50.times do |j|
      # remember to tweak puma and db config for this to make sense (eg. pool, workers, threads)
      threads << Thread.new do
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.request_uri)
        res = http.request(req)
        print "."
        counter = res.body.to_i
      end
    end

    threads.each do |thr|
      counters << thr.join.value
    end

    puts
    uri = URI.parse("http://localhost:3000/read_write/fetch")
    req = Net::HTTP::Get.new(uri.to_s)
    res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
    counter = res.body.to_i
    puts counter
    puts
  end
end

puts "Not safe"
puts "========"
test("http://localhost:3000/read_write/not_safe")

puts "Safe"
puts "========"
test("http://localhost:3000/read_write/safe")
