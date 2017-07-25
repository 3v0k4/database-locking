require_relative "request_helpers"

NUMBER_OF_THREADS = 5
NUMBER_OF_RUNS = 3

def test(url)
  NUMBER_OF_RUNS.times do |i|
    puts "run ##{i+1}"
    `bin/rails db:seed`

    params = [
      { color: "yellow" },
      { color: "brown" },
      { color: "pink" },
      { color: "green" },
      { color: "purple" },
    ]
    responses = concurrent_post(number_of_threads: NUMBER_OF_THREADS, url: url, params: params)

    puts
    counters = get(url: "http://localhost:3000/write_write/fetch")
    puts counters
    puts
  end
end

puts "Not safe"
puts "========"
test("http://localhost:3000/write_write/not_safe")

puts "Safe"
puts "========"
test("http://localhost:3000/write_write/safe")
