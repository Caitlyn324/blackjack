require "csv"
require_relative "game"
require "pry"

replay = true
returning_player = false
result_to_save_state = {
  won: :wins,
  lost: :losses,
  stalemate: :stalemates,
  natural: :naturals
}
# read in memory card
profiles = {}
CSV.foreach("data.csv", :headers => true, :header_converters => :symbol, :converters => :all) do |row|
  profiles[row.fields[0]] = Hash[row.headers[1..-1].zip(row.fields[1..-1])]
end

# Check if the player is returning
print "Please Enter Name: "
name = gets.chomp

if profiles.keys.include?(name)
  returning_player = true
  puts "\nWelcome Back, #{name}! "
else
  returning_player = false
  puts "\nWelcome to Blackjack! Here's your scorecard:"
end


while replay
  puts "********Player Stats********"
  profiles[name].each do |datapoint, value|
    puts "#{datapoint.to_s.upcase}: #{value}"
  end
  puts "****************************\nLet's Play!\n\n"

# play the Game and return the results
  round = Game.new(name)
  results = round.play

# update the profiles hash so we know what to update where in the memory card
  if !returning_player
    profiles[name] = {} # fine
    for stat in result_to_save_state.values do
      profiles[name][stat] = 0
    end
  end

  headers = []
  index = 0
  headers[index] = "name"
  result_to_save_state.each do |result, save_datapoint|
    index += 1
    headers[index] = save_datapoint.to_s
    if results[result]
      profiles[name][save_datapoint] += 1
    end
  end

# write the results to the memory card
  CSV.open("data.csv", "wb") do |csv|
    csv << headers
    profiles.each do |name, data|
      csv_array = []
      csv_array << name
        data.each do |datapoint, value|
          csv_array << value
        end
      csv << csv_array
    end
  end

# Check if player would like to play again
  input = ""
  while input.downcase != "y" && input.downcase != "n"
    print "Would you like to play again? (Y/N): "
    input = gets.chomp
    if input.downcase == "y"
      replay = true
    elsif input.downcase == "n"
      replay = false
    else
      puts "INVALID RESPONSE. SYSTEM INDICATE USER WAS DROPPED ON HEAD AS CHILD. A LOT."
    end
  end
end
puts "Thanks For Playing!"
