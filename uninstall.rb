# Remove arquivos
#
dir = "javascripts"
files = Dir.glob(File.join(File.dirname(__FILE__),dir,"*"))

files.each do |file|
  file_name = file.split('/').last
  dest = File.join(RAILS_ROOT,"public",dir)
  if File.exists?(File.join(dest,file_name))
    FileUtils.rm_r(File.join(dest,file_name))
  end
end
