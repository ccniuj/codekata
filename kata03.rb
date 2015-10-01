#kata03

#How Big?
#1. Roughly how many binary digits (bit) are required for the unsigned representation of:

#1,000 => 10 bits
#1,000,000 => 20 bits
#1,000,000,000 => 30 bits
#1,000,000,000,000 => 40 bits
#8,000,000,000,000 => 43 bits

#2. My town has approximately 20,000 residences. 
#    How much space is required to store the names, addresses, 
#    and a phone number for all of these (if we store them as characters)?

#1 byte (8 bits) for each character
#There are about 100 byte for each residence's data
#Require 20000*100 = 2Mb

#3. I’m storing 1,000,000 integers in a binary tree. 
#    Roughly how many nodes and levels can I expect the tree to have? 
#    Roughly how much space will it occupy on a 32-bit architecture?

#node: 1000000
#level: 20
#32-bit for each integer => 32*3 bits for each node => require 96*1M bits ~ 100Mb

#How Fast?
#1. My copy of Meyer’s Object Oriented Software Construction has about 1,200 body pages. 
#Assuming no flow control or protocol overhead, about how long would it take to send it over an async 56k baud modem line?
#size: 16.6Mb
#rate: 56kbits/s = 7Kb/s
#time = 16.6*1000/7 = 2371.4s ~ 40mins

#2. My binary search algorithm takes about 4.5mS to search a 10,000 entry array, 
#    and about 6mS to search 100,000 elements. 
#    How long would I expect it to take to search 10,000,000 elements (assuming I have sufficient memory to prevent paging).
#time complexity of binary search: O(log n)
#n increases 10 times, time increases 1.5 ms
#n increases 100 times, time increases 1.5 * 2 = 3ms
#Require 6ms + 3ms = 9ms

#3. Unix passwords are stored using a one-way hash function: 
#    the original string is converted to the ‘encrypted’ password string, 
#    which cannot be converted back to the original string. 
#    One way to attack the password file is to generate all possible cleartext passwords, 
#    applying the password hash to each in turn and checking to see if the result matches the password you’re trying to crack. 
#    If the hashes match, then the string you used to generate the hash is the original password 
#    (or at least, it’s as good as the original password as far as logging in is concerned). 
#    In our particular system, passwords can be up to 16 characters long, 
#    and there are 96 possible characters at each position. 
#    If it takes 1mS to generate the password hash, is this a viable approach to attacking a password?

#amount of all possible passwords: 96^16 ~ 10^32
#Require 10^32/1000/60/60/24/365 = 3.17*10^21 yr
