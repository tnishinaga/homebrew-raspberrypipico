# based on https://github.com/Homebrew/homebrew-core/blob/master/Formula/open-ocd.rb
class OpenOcdPico < Formula
    desc "OpenOCD for Raspberry Pi Pico"
    homepage "https://openocd.org/"
    url "https://github.com/raspberrypi/openocd.git"
    license "GPL-2.0-or-later"
  
    head do
      url "https://github.com/raspberrypi/openocd.git"
      branch "rp2040"
  
      depends_on "autoconf" => :build
      depends_on "automake" => :build
      depends_on "libtool" => :build
      depends_on "texinfo" => :build
    end
  
    depends_on "pkg-config" => :build
    depends_on "capstone"
    depends_on "hidapi"
    depends_on "libftdi"
    depends_on "libusb"
    depends_on "libusb-compat"
  
    def install
      ENV["CCACHE"] = "none"
  
      system "./bootstrap", "nosubmodule" if build.head?
      system "./configure", "--disable-dependency-tracking",
                            "--prefix=#{prefix}",
                            "--enable-buspirate",
                            "--enable-stlink",
                            "--enable-dummy",
                            "--enable-jtag_vpi",
                            "--enable-remote-bitbang",
                            "--enable-picoprobe"
      system "make", "install"
    end
  end
