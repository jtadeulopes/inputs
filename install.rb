# Copia os arquivos
#
dir = "javascripts"
files = Dir.glob(File.join(File.dirname(__FILE__),dir,"*"))

files.each do |file|
  file_name = file.split('/').last
  source = File.join(file)
  dest = File.join(RAILS_ROOT,"public",dir)
  unless File.exists?(File.join(dest,file_name))
    FileUtils.cp_r(source,dest)
  end
end
