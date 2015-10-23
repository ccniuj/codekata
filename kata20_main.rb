#kata20 main program
require_relative 'kata20'

# initializing game

k = Klondike.new
k.start_new_game
while true
  break if k.foundation.map { |f| f.length }.reduce { |sum, r| sum+r } == 52
  k.show
  case k.operation_prompt(%w{send_card move_card flip restart_stock new_game})
  when 1
    k.send
  when 2
    k.type_prompt(%w{tableau:1 tableau:2 tableau:3 tableau:4 tableau:5 tableau:6 tableau:7 discard foundation})
  when 3
    k.flip_prompt(%w{tableau:1 tableau:2 tableau:3 tableau:4 tableau:5 tableau:6 tableau:7})
  when 4
    k.restart
  when 5
    k = Klondike.new
    k.start_new_game
  else
    p 'No sush operation!'
  end
end
puts "YOU WIN!!"