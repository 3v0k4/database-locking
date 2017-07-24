require_relative "request_helpers"

def test(url)
  5.times do |i|
    puts "run ##{i+1}"
    `bin/rails db:seed`

    responses = concurrent_post(number_of_threads: 5, url: url, params: [{ unique: { name: "same_name" }}])

    puts
    puts responses
    puts get(url: "http://localhost:3000/write/fetch")
    puts
  end
end

puts "Create"
puts "========"
test("http://localhost:3000/write/create")
