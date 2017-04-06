# Array methods
class Array
  def write_bib(file)
    File.open(file, 'a') do |f|
      f.puts self
    end
  end
end
