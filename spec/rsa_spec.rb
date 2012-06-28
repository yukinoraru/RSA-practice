#coding:utf-8

require './lib/rsa.rb'

describe RSA do

  describe '#cipher_text' do
    before :each do
      @cipher_text = [
        "That's Deneb, Altair, and Vega.",
        "あれがデネブ、アルタイル、ベガ。",
        "あれがDeneb、Altair、Vega.",
      ]
    end
    it '1もしくは2バイト文字で構成された文字列を正しく数値配列にできるかどうか' do
      @cipher_text.each do |text|
        numerical = RSA.numbering(text)
        text.length.should == numerical.length
      end
    end
    it '数値配列を暗号化して復号化するともどるかどうか(p, q, e, d = 1193, 101, 199, 599)' do
      @cipher_text.each do |text|

        # ここでは2バイト文字までのUTF8を暗号/復号化できるp,qを使う
        numerical = RSA.numbering(text)
        p, q, e, d = 1193, 101, 199, 599

        encrypt = RSA.code(p*q, e, numerical)
        decrypt = RSA.code(p*q, d, encrypt)

        RSA.unnumbering(numerical).should == RSA.unnumbering(decrypt)
      end
    end
    it '巨大な数で暗号化・復号化出来るかどうか' do
      n, e, d = 1223460961843067, 65537, 115276424115473
      numerical = RSA.numbering("うっほうっほうほほほ冪剰余")

      encrypt = RSA.code(n, e, numerical)
      decrypt = RSA.code(n, d, encrypt)

      #pp numerical, encrypt, decrypt

      RSA.unnumbering(numerical).should == RSA.unnumbering(decrypt)
    end
  end

  describe '#known_test' do
    it "既知の暗号結果と一致するかどうか(p=3,q=7,e=5,d=17)" do
      RSA.code(3*7, 5, [4]).should == [16]
    end
    it "既知の復号結果と一致するかどうか(p=3,q=7,e=5,d=17,M=16)" do
      RSA.code(3*7, 17, [16]).should == [4]
    end
    it "p=3,q=7のとき最小のe,dの組み合わせを導けるかどうか" do
      #pp RSA.find_keypair(1193, 101)
      key_pair = RSA.find_keypair(3, 7, max_keypair: 1).first
      key_pair.first.should == 5
      key_pair.last.should  == 17
    end
  end

  describe "#finding_keypair" do

  end


end
