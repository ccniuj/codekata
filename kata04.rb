#kata04
#part1
# File.open("weather.dat", "r") do |f|
#   count = 0
#   arr = Array.new
#   diff = Array.new

#   f.each_line do |line|
#     if count != 0 then
#       arr = line.split(' ')
#       diff << [arr[0], arr[1].to_i - arr[2].to_i]
#     end
#     count += 1
#   end
#   puts diff.sort_by{|x, y|y}.last[0]

# end

#part2
File.open("football.dat", "r") do |f|
  count = 0
  diff = Array.new

  f.each_line do |line|
    if count != 0 then
      arr = line.split(' ')
      diff << [arr[1], (arr[6].to_i - arr[8].to_i).abs] if arr[1]
    end
    count += 1
  end
  puts diff.sort_by{|x, y|y}.first[0]
end
