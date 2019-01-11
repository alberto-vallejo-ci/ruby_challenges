# Friends:
#   Alice: Bob, Carl, Dan
#   Bob: Alice, Ed, Greg
#   Ed: Hal
#   Carl: Hal

# u1 = Alice
# u1.friends = [Bod, Carl, Dan]
# u1.name = "Alice"

def min_jumps(u1, u2)
  jumps ||= 0
  blacklist ||= []
  jumps_list ||= []

  return 0 if (u1 == u2)

  jumps += 1

  if u1.friends.include?(u2)
    return jumps
  else
    blacklist << u1

    u1.friends.each do |friend|
      next if blacklist.include?(friend) # Prevent infinite loops
      jumps_list << min_jumps(friend, u2)
    end

    return jumps_list.min
  end
end

# min_jumps(Alice, Alice) => 0
# min_jumps(Alice, Bob) => 1
# min_jumps(Alice, Ed) => 2
# min_jumps(Alice, Hal) => 2
