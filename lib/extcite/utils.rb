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

def make_paths(x)
	path = Array(x)
  if path.length == 1
    # if a directory
    if File.directory?(path[0])
      # keep only files with .pdf extension
      path = dir_files(path[0]).keep_if { |z| !!z.match(/.pdf/) }
    end
  end

  # check that files exist
  path.each do |x|
    if !File.exist?(x)
      raise x + ' not found'
    end
  end

  return path
end

def pdf_doi(x)
  xml = Oga.parse_xml(x)
  begin
    tt = xml.xpath('//rdf:Description')
    return tt.attr('dc:identifier')[0].text.sub(/doi:/, '')
  rescue
    return nil
  end
end
