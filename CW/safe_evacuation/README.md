### Domain safe_evacuation

The domainPart1 folder is code about trucks carrying the relief_supplies
It can be viewed as isolated domain
The problem1 file (ignore some objects, which are not used) only catch the goal states, which tell us to drop relief_supplies to each shelter

The domainPart2 folder is code about ambulances saving the casualties
It can be viewed as isolated domain
The problem1 file (ignore some objects,which are not used) only catch the goal states, which tell us to save casualties to two hospitals (St Thomas & Guys hospital)

The domainPart3 folder is code about shuttles taking the passages
It can be viewed as isolated domain
There are two kinds of people,
  Individual People can take the shuttle by way2. Group people take the shuttle by way1.
  When the group people move into the shelter, it means all people in this whole group have arrived.
The problem1 file is the simplest version with only 4 locations
The problem2 file  catch the goal states, which just make sure all people are in the shelter.

The CombinedDomain is a folder combined all the domains above, and it works.
The problem1 simply combine all problem1 files above. The total time should be the longest time among the above three problem1 files.
The problem2 is harder than problem1
