namespace :inputs do

  desc "Copies the Inputs javascripts to puplic/javascripts"
  task :install do
    dest = File.join(RAILS_ROOT,"public",'javascripts')
    files = Dir[File.join(File.dirname(__FILE__), '..', '/javascripts/', '*.js')]
    FileUtils.cp(files, dest)
    puts "Files copied =)"
  end

  desc "Update the Inputs javascripts"
  task :update do
    dest = File.join(RAILS_ROOT,"public",'javascripts')
    files = %W[maskedinput.js price.js]
    files.each do |file|
      FileUtils.rm(File.join(dest, file)) if File.exists?(File.join(dest, file))
    end
    puts "Files updated =)"
  end

end

