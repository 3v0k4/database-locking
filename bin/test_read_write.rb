require_relative "request_helpers"

def test(url)
  5.times do |i|
    puts "run ##{i+1}"
    `bin/rails db:seed`

    concurrent_post(number_of_threads: 50, url: url)

    puts
    puts get(url: "http://localhost:3000/read_write/fetch")
    puts
  end
end

puts "Not safe"
puts "========"
test("http://localhost:3000/read_write/not_safe")

puts "Safe"
puts "========"
test("http://localhost:3000/read_write/safe")
