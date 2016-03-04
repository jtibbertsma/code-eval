# Load every ruby file in this directory. This won't cause any namespace issues, since
# I've been careful to wrap all code in uniquely named modules. Also, each file is
# written so that the program isn't executed when the file is required.

def load_codeeval_ruby_files(directory = '.')
  print "Loading Code Eval ruby files...\n\n"
  files = `find #{directory} -type f -name *.rb`
  files.split(/\s+/).each do |f|
    begin
      load File.expand_path(f)
    rescue Exception => e
      puts "failed loading '#{f[/\b[\-\w]+\/.*rb$/]}': #{e}"
    end
  end
  puts "Done"
end

load_codeeval_ruby_files
