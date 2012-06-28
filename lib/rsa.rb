#coding:utf-8

module CipherText
  def numbering(str)
    str.unpack("U*")
  end
  def unnumbering(arr)
    arr.pack("U*")
  end
end

module KeyManager
  def gcd(x, y)
    if y == 0
      return x
    else
      return gcd(y, x%y)
    end
  end
  def find_keypair(p, q, options={})
    options = {:max_keypair => 1}.merge(options)
    k = (p-1)*(q-1)
    list_e, list_d = [], []
    1.upto(k) do |i|
      tmp = gcd(i, k)
      if tmp == 1
        list_e << i if i != 1
        if list_e.length >= options[:max_keypair]
          break
        end
      end
    end
    list_e.each do |e|
      cnt = 1
      loop do
        cnt += 1
        #p "e=#{e}, cnt=#{cnt}, k=#{k}, result=#{(e*cnt) % k}"
        if (e*cnt) % k == 1 && e != cnt
          list_d << cnt
          break
        end
      end
    end
    return list_e.zip(list_d)
  end
end

class RSA
  extend CipherText
  extend KeyManager
  # 巨大数の冪剰余を計算する
  # a^n (mod m)
  def self.modpow(a, n, m)
    r = 1
    while true
      r = r * a % m if n[0] == 1
      n >>= 1
      return r if n == 0
      a = a * a % m
    end
  end
  def self.code(n, k, message)
    if !message.kind_of?(Array)
      raise ArgumentError, "message must be kind of Array."
      return nil
    end
    message.collect do |m|
      self.modpow(m, k, n)
    end
  end

end
