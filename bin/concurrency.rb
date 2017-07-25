NUMBER_OF_RUNS = 5
NUMBER_OF_THREADS = 5
NUMBER_OF_INCREMENTS = 100_000

NUMBER_OF_RUNS.times do |i|
  puts "run ##{i+1}"

  counters = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]

  NUMBER_OF_THREADS.times.map do
    Thread.new do
      NUMBER_OF_INCREMENTS.times do
        counters.map! { |counter| counter + 1 }
      end
    end
  end.each(&:join)

  puts counters.join(" ")
  puts
end

