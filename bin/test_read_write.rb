require_relative "request_helpers"

NUMBER_OF_THREADS = 50
NUMBER_OF_RUNS = 3

def test(url)
  NUMBER_OF_RUNS.times do |i|
    puts "run ##{i+1}"
    `bin/rails db:seed`

    concurrent_post(number_of_threads: NUMBER_OF_THREADS, url: url)

    puts
    counter = get(url: "http://localhost:3000/read_write/fetch")
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
