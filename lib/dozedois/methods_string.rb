require 'oga'
require 'bibtex'

# String methods
class String
  def write_bib(file)
    File.open(file, 'a') do |f|
      f.puts self
    end
  end
end

class String
	def make_bib_arxiv(id)
		# prep xml
		xml = Oga.parse_xml(self)
		#xml = Oga.parse_xml(x)
		author = xml.xpath('//author//name')[0].text.downcase.gsub(/\s|\./, '_')
		year = DateTime.strptime(xml.xpath('//updated')[0].text).year
		authoryear = author + "_" + year.to_s

		# make bib citation
		bib = BibTeX::Bibliography.new
		bib << BibTeX::Entry.new({
		  :bibtex_type => :article,
		  :url => xml.xpath('//entry/id').text,
		  :author => xml.xpath('//author//name').collect { |x| x.text }.join(' and '),
		  :eprint => id,
		  :title => xml.xpath('//entry//title').text,
		  :year => year
		})
		return bib.to_s
	end
end
