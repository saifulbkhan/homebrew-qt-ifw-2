class QtIfw2 < Formula
  desc "The Qt Installer Framework"
  homepage "http://doc.qt.io/qtinstallerframework/"
  url "https://download.qt.io/official_releases/qt-installer-framework/2.0.5/qt-installer-framework-opensource-2.0.5-src.tar.gz"
  sha256 "c7f5f20cf8ffbb0f8392c9ef954a10ac1dee78ee5b94fb9ea0550061bd57db22"
  head="http://code.qt.io/cgit/installer-framework/installer-framework.git/"

  depends_on "qt"

  def install

    cd "src/libs/7zip" do
      inreplace "7zip.pro" do |s|
        s.gsub! "$$[QT_INSTALL_LIBS]", lib
      end
    end

    cd "src/libs/installer" do
      inreplace "installer.pro" do |s|
        s.gsub! "$$[QT_INSTALL_LIBS]", lib
      end
    end

    cd "src/sdk" do
      inreplace "sdk.pro" do |s|
        s.gsub! "$$[QT_INSTALL_BINS]", bin
      end
    end

    cd "tools/archivegen" do
      inreplace "archivegen.pro" do |s|
        s.gsub! "$$[QT_INSTALL_BINS]", bin
      end
    end

    cd "tools/binarycreator" do
      inreplace "binarycreator.pro" do |s|
        s.gsub! "$$[QT_INSTALL_BINS]", bin
      end
    end

    cd "tools/repogen" do
      inreplace "repogen.pro" do |s|
        s.gsub! "$$[QT_INSTALL_BINS]", bin
      end
    end

    cd "tools/devtool" do
      inreplace "devtool.pro" do |s|
        s.gsub! "$$[QT_INSTALL_BINS]", bin
      end
    end

    system "qmake", "installerfw.pro", "-r", "-spec", "macx-clang", "-config", "release", "PREFIX=#{prefix}"
    system "make", "install"

  end

  test do
    assert shell_output("#{bin}/binarycreator -h")
  end  
end
