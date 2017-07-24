require_relative "request_helpers"

def test(url)
  5.times do |i|
    puts "run ##{i+1}"
    `bin/rails db:seed`

    params = [
      { first: 1, second: 1 },
      { first: 2, second: 2 },
      { first: 3, second: 3 },
      { first: 4, second: 4 },
      { first: 5, second: 5 },
    ]
    responses = concurrent_post(number_of_threads: 5, url: url, params: params)

    puts
    puts get(url: "http://localhost:3000/write_write/fetch")
    puts
  end
end

puts "Not safe"
puts "========"
test("http://localhost:3000/write_write/not_safe")

puts "Safe"
puts "========"
test("http://localhost:3000/write_write/safe")
