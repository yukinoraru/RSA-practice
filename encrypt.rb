#coding:utf-8

require 'pp'
require 'yaml'
require './lib/rsa.rb'

if ARGV.length == 0 then
  STDERR.puts sprintf("USAGE: ruby %s [encrypt.yml]", File.basename(__FILE__))
  exit 1
end

data = YAML.load(File.open(ARGV[0]))

cipher_text = data["cipher_text"]
numerical   = RSA.numbering(cipher_text)
n           = data["n"]
e           = data["e"]
d           = data["d"]

encrypt   = RSA.code(n, e, numerical)
decrypt   = RSA.code(n, d, encrypt)

puts "cipher text: "       + cipher_text
puts "cipher text(hex): "  + numerical.collect{|n| "%02x" % n}.join(" ")
puts "encrypt text(hex): " + encrypt.collect  {|n| "%02x" % n}.join(" ")
puts "decrypt text(hex): " + RSA.unnumbering(decrypt)

