require_relative "request_helpers"

NUMBER_OF_THREADS = 4
NUMBER_OF_RUNS = 3

def test(url_1, url_2)
  NUMBER_OF_RUNS.times do |i|
    puts "run ##{i+1}"
    `bin/rails db:seed`

    responses_1 = concurrent_gets_2(number_of_threads: NUMBER_OF_THREADS / 2, url_1: url_1, url_2: url_2)
    responses_2 = concurrent_gets_2(number_of_threads: NUMBER_OF_THREADS / 2, url_1: url_1, url_2: url_2)

    puts
    puts (responses_1 + responses_2)
    puts
  end
end

puts "Not safe"
puts "========"
test("http://localhost:3000/read_read/not_safe_1", "http://localhost:3000/read_read/not_safe_2")

puts "Safe"
puts "========"
test("http://localhost:3000/read_read/safe", "http://localhost:3000/read_read/safe")
