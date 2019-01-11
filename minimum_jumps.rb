# Recursive Challenge
# Find the minimum jumps between two given users from a collection of users with friends.

# Current Status: Done.

# Friends:
#   Alice: Bob, Carl, Dan
#   Bob: Alice, Ed, Greg
#   Ed: Hal
#   Carl: Hal
#   Hal: Mark
#   Mark: Bob, Alice, John
#   John: Laura

friends = {
  alice: %i(bob carl dan),
  bob: %i(alice ed greg),
  ed: %i(hal),
  carl: %i(hal),
  hal: %i(mark),
  mark: %i(bob alice john),
  john: %i(laura),
}

def min_jumps(u1, u2, friends, jumps = 0, blacklist = [])
  jumps_list ||= {}

  return jumps if u1 == u2

  blacklist = blacklist.slice(0, 1) if jumps == 1 # Reset Blacklist when starting a new path

  jumps += 1

  return jumps if friends[u1].include?(u2)

  blacklist << u1

  friends[u1].each do |friend|
    next if blacklist.include?(friend) || friends[friend].nil? # Return if into the blacklist or has no friends :(
    jumps_list[friend] = min_jumps(friend, u2, friends, jumps, blacklist)
  end

  result = jumps_list.any? ? jumps_list.values.compact.min : nil # if jumps_list is empty, return nil instead of {}

  return result
end

puts min_jumps(:alice, :alice, friends)
# => 0
# path: Alice - Alice => 0

puts min_jumps(:alice, :bob, friends)
# => 1
# path: Alice -> Bob => 1

puts min_jumps(:alice, :ed, friends)
# => 2
# path: Alice -> Bob -> Ed => 2

puts min_jumps(:alice, :hal, friends)
# => 2
# path: Alice -> Carl -> Hal => 2

puts min_jumps(:alice, :mark, friends)
# => 3
# path: Alice -> Carl -> Hal -> Mark => 3

puts min_jumps(:alice, :laura, friends)
# => 5
# path: Alice -> Carl -> Hal -> Mark -> John -> Laura => 5
