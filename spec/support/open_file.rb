def open_file(file) 
  File.open(File.join(File.dirname(__FILE__), '..' , file))
end
