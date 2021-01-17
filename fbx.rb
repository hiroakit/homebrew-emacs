# coding: utf-8
# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Fbx < Formula
  desc "FBX SDK for macOS"
  homepage "https://www.autodesk.com/developer-network/platform-technologies/fbx"
  url "https://www.autodesk.com/content/dam/autodesk/www/adn/fbx/2020-2/fbx20202_fbxsdk_clang_mac.pkg.tgz"
  version "20202"
  sha256 "18ee9f9fadb0c3c9b674283415c8346d7651295f67e3fcc0b5336d46a2967aee"
  license "It deefined by Autodesk"

  def install
    pkg_file_name = "fbx20202_fbxsdk_clang_macos"    
    pkg_file_name_full = "#{pkg_file_name}.pkg"
    
    Dir.mktmpdir("fbxsdk") do |dir|
      system "tar", "xzvf", "#{cached_download}", "-C", "#{dir}"
      system "pkgutil", "--expand", "#{dir}/#{pkg_file_name_full}", "#{dir}/#{pkg_file_name}"
      system "ditto", "-x", "--bom", "#{dir}/#{pkg_file_name}/Root.pkg/Bom", "#{dir}/#{pkg_file_name}/Root.pkg/Payload", "#{dir}/#{pkg_file_name}/expanded"      

      fbx_sdk_base_path = "#{dir}/#{pkg_file_name}/expanded/Applications/Autodesk/FBX SDK/2020.2"
      fbx_sdk_lib_path = "#{fbx_sdk_base_path}/lib/clang/release"
      fbx_sdk_include_path = "#{fbx_sdk_base_path}/include/"
   
      lib.install Dir["#{fbx_sdk_lib_path}/*"]
      include.install Dir["#{fbx_sdk_include_path}/*"]
      system "cp", "#{fbx_sdk_base_path}/License.rtf", "#{prefix}"
    end    
  end
  
  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test fbx`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
