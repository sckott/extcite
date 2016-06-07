# Array methods
class Array
  def write_bib(file)
    File.open(file,'w') do |f|
      f.puts self
    end
  end
end
