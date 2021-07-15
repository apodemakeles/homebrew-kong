class Kong < Formula
  desc "Open source Microservices and API Gateway"
  homepage "https://docs.konghq.com"

  KONG_OPENRESTY_VERSION = "1.17.8.2"

  stable do
    url "https://download.konghq.com/gateway-src/kong-2.2.0.tar.gz"
    sha256 "bf3006018117e66df3bb6b303a80439b1c2528dc36d2edeb6c032e7e60c5736e"
  end

  #devel do
  #  url "https://github.com/Kong/kong.git", :tag => "2.1.0-rc.1"
  #end

  head do
    url "https://github.com/Kong/kong.git", :branch => "next"
  end

  depends_on "libyaml"
  depends_on "apodemakeles/kong/openresty@#{KONG_OPENRESTY_VERSION}"

  patch :DATA

  def install
    openresty_prefix = Formula["apodemakeles/kong/openresty@#{KONG_OPENRESTY_VERSION}"].prefix

    luarocks_prefix = openresty_prefix + "luarocks"
    openssl_prefix = openresty_prefix + "openssl"

    system "#{luarocks_prefix}/bin/luarocks",
           "--tree=#{prefix}",
           "make",
           "CRYPTO_DIR=#{openssl_prefix}",
           "OPENSSL_DIR=#{openssl_prefix}"

    bin.install "bin/kong"
  end
end
