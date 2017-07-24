require "net/http"
require "uri"
require "json"

def concurrent_gets(number_of_threads:, url:)
  number_of_threads.times.map do
    Thread.new do
      uri = URI.parse(url)
      req = Net::HTTP::Get.new(uri.to_s)
      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
      print "."
      res.body
    end
  end.map do |thread|
    thread.join.value
  end
end

def concurrent_gets_2(number_of_threads:, url_1:, url_2:)
  number_of_threads.times.map do |i|
    Thread.new do
      uri = URI.parse(url_1)
      uri = URI.parse(url_2) if (i % 2 == 0)
      req = Net::HTTP::Get.new(uri.to_s)
      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
      print "."
      res.body
    end
  end.map do |thread|
    thread.join.value
  end
end

def concurrent_post(number_of_threads:, url:, params: [])
  number_of_threads.times.map do |i|
    Thread.new do
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.request_uri)
      unless params.empty?
        req.content_type = "application/json"
        req.body = params.first.to_json
        req.body = params[i].to_json if params.length > 1
      end
      res = http.request(req)
      print "."
      res.body
    end
  end.map do |thread|
    thread.join.value
  end
end

def get(url:)
  uri = URI.parse(url)
  req = Net::HTTP::Get.new(uri.to_s)
  res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
  res.body
end
