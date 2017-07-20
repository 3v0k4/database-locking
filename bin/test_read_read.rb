require "net/http"
require "uri"
require "json"
require "benchmark"
require "byebug"

def test(url, url_2 = nil)
  5.times do |i|
    puts "run ##{i+1}"
    `bin/rails db:seed`
    responses = []
    threads = []

    5.times do |j|
      # remember to tweak puma and db config for this to make sense (eg. pool, workers, threads)
      threads << Thread.new do
        uri = URI.parse(url)
        uri = URI.parse(url_2) if (url_2 && j % 2 == 0)
        req = Net::HTTP::Get.new(uri.to_s)
        res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
        print "."
        response = res.body
      end
    end

    threads.each do |thr|
      responses << thr.join.value
    end

    puts
    puts responses.join(" ")
    puts
  end
end

puts "Not safe"
puts "========"
test("http://localhost:3000/read_read/not_safe_1", "http://localhost:3000/read_read/not_safe_2")

puts "Safe"
puts "========"
test("http://localhost:3000/read_read/safe")
