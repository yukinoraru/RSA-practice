#coding:utf-8

require 'pp'
require './lib/rsa.rb'

print "Please input p,q: "
input = gets.chomp.split(",")
if input.length != 2
  STDERR.puts "input is incorrect. input format requires like '13,19'"
  exit
end
p = input.first.strip.to_i
q = input.last.strip.to_i

MAX = 300
key_pairs = RSA.find_keypair(p, q, max_keypair: MAX)

puts "p=#{p}, q=#{q}, #{key_pairs.length} key pairs were found. (max = #{MAX})"
key_pairs.each_with_index do |ed, i|
  e = ed.first
  d = ed.last
  puts "pair no.#{i+1}: e=#{e}, d=#{d}"
end

#pp key_pairs, key_pairs.length