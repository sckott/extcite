def singlearray2hash(x)
  if x.length == 1 && x.class == Array
    return x[0]
  else
    return x
  end
end

def dir_files(x)
	Dir.entries(x).select { |entry|
		!File.directory? File.join(x, entry) and !(entry =='.' || entry == '..')
	}.map { |z|
		x + '/' + z
	}
end
