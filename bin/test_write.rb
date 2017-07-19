require "net/http"
require "uri"
require "json"
require "benchmark"
require "byebug"

def test(url)
  5.times do |i|
    puts "run ##{i+1}"
    `bin/rails db:seed`
    ress = []
    threads = []

    5.times do |j|
      # remember to tweak puma and db config for this to make sense (eg. pool, workers, threads)
      threads << Thread.new do
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.request_uri)
        req.content_type = "application/json"
        req.body = { unique: { name: "same_name" }}.to_json
        res = http.request(req)
        print "."
        res.body
      end
    end

    threads.each do |thr|
      ress << thr.join.value
    end

    puts
    puts ress
    uri = URI.parse("http://localhost:3000/write/fetch")
    req = Net::HTTP::Get.new(uri.to_s)
    res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
    ids = res.body
    puts ids
    puts
  end
end

puts "Create"
puts "========"
test("http://localhost:3000/write/create")
