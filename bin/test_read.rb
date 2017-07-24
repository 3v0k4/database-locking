require_relative "request_helpers"

NUMBER_OF_THREADS = 5
NUMBER_OF_RUNS = 5

def test(url)
  NUMBER_OF_RUNS.times do |i|
    puts "run ##{i+1}"
    `bin/rails db:seed`

    responses = concurrent_gets(number_of_threads: NUMBER_OF_THREADS, url: url)

    puts
    puts responses.join(" ")
    puts responses.uniq.size
    puts
  end
end

puts "Not safe"
puts "========"
test("http://localhost:3000/read/not_safe")

puts "Safe"
puts "========"
test("http://localhost:3000/read/safe")
