class Kong < Formula
  desc "Open source Microservices and API Gateway"
  homepage "https://docs.konghq.com"

  KONG_OPENRESTY_VERSION = "1.19.3.1"
  KONG_VERSION = "2.5.0"

  stable do
    url "https://download.konghq.com/gateway-src/kong-#{KONG_VERSION}.tar.gz"
    sha256 "b7d6c00143e69998a91ea603edc9996f79032a1af9c3801b1903076f2ba77708"
  end

  head do
    url "https://github.com/Kong/kong.git", :branch => "master"
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
