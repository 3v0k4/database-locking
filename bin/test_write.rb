require_relative "request_helpers"

NUMBER_OF_THREADS = 5
NUMBER_OF_RUNS = 3

def test(url)
  NUMBER_OF_RUNS.times do |i|
    puts "run ##{i+1}"
    `bin/rails db:seed`

    params = [{ unique: { name: "same_name" }}]
    responses = concurrent_post(number_of_threads: NUMBER_OF_THREADS, url: url, params: params)

    puts
    puts responses
    puts get(url: "http://localhost:3000/write/fetch")
    puts
  end
end

puts "Create"
puts "========"
test("http://localhost:3000/write/create")
