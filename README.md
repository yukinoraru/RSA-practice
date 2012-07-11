#RSA Practice [![Build Status](https://secure.travis-ci.org/yukinoraru/RSA-practice.png)](http://travis-ci.org/yukinoraru/RSA-practice)

##Feature:

 This RSA implementation is fairly simple and include some tests that deal UTF-8 context.


##Testing:

  - Local: RSpec + Guard
  - Remote: Travis CI

##Usage:

At first time you need to `bundle install`

####Testing (require Rake or Gurad)

Simply type `rake` or `guard` command. That's it.

####Generate private key
`ruby keyfinder.rb`

<pre>
Please input p,q: 13,19
p=13, q=19, 71 key pairs were found. (max = 300)
pair no.1: e=5, d=173
pair no.2: e=7, d=31
pair no.3: e=11, d=59
pair no.4: e=13, d=133
pair no.5: e=17, d=89
....
</pre>

####Encryption & Decryption
`ruby encrypt.rb encrypt.yml`
<pre>
cipher text: abcdefghijklmnopqrstuvwxyz
cipher text(hex): 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f 70 71 72 73 74 75 76 77 78 79 7a
encrypt text(hex): b8 a7 70 ed 2b a3 0c 82 4f 2d d9 a6 c8 02 e8 b1 5e 5f 14 33 5b 83 7b 64 31 1f
decrypt text: abcdefghijklmnopqrstuvwxyz
</pre>


Trying encode/decode strings in UTF-8

`ruby encrypt.rb encrypt-utf8.yml`
<pre>
cipher text: 漢字ｶﾀｶﾅひらがなカタカナ
cipher text(hex): 6f22 5b57 ff76 ff80 ff76 ff85 3072 3089 304c 306a 30ab 30bf 30ab 30ca
encrypt text(hex): 36ca301eb5b6 444e96a5fa6a6 523b4b43638c 36f410cf39f11 523b4b43638c 264e78150a1fa 49069afb5e8f 24d7ecc1a1dd9 280c79ef3f691 26fb47005861a 413567d05ca4b 428a96d0262f 413567d05ca4b 1997cc9f36a31
decrypt text: 漢字ｶﾀｶﾅひらがなカタカ
</pre>

#####Encryption Data Format(YAML)
`cat  encrypt.yml`

<pre>
---
cipher_text: abcdefghijklmnopqrstuvwxyz
n: 247
e: 113
d: 65
</pre>
