# Recursive Challenge
# Find the minimum jumps between two provided users from a collction of users and friends.

# Current Status: Done.

# Friends:
#   Alice: Bob, Carl, Dan
#   Bob: Alice, Ed, Greg
#   Ed: Hal
#   Carl: Hal
#   Hal: Mark

# u1 = Alice
# u1.friends = [Bod, Carl, Dan]
# u1.name = "Alice"

friends = {
  alice: %i(bob carl dan),
  bob: %i(alice ed greg),
  ed: %i(hal),
  carl: %i(hal),
  hal: %i(mark)
}

def min_jumps(u1, u2, friends, jumps = 0, blacklist = [])
  # jumps ||= 0
  # blacklist ||= []
  jumps_list ||= {}

  return jumps if u1 == u2

  jumps += 1

  return jumps if friends[u1].include?(u2)

  blacklist << u1

  friends[u1].each do |friend|
    next if blacklist.include?(friend) || friends[friend].nil? # Return if into the blacklist or has no friends :(
    jumps_list[friend] = min_jumps(friend, u2, friends, jumps, blacklist)
  end

  result = jumps_list.any? ? jumps_list.values.compact.min : nil

  return result
end

puts min_jumps(:alice, :alice, friends)
# => 0
puts min_jumps(:alice, :bob, friends)
# => 1
puts min_jumps(:alice, :ed, friends)
# => 2
puts min_jumps(:alice, :hal, friends)
# => 2
puts min_jumps(:alice, :mark, friends)
# => 3
