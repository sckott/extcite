require "extcite/utils"
require "extcite/methods_array"
require "extcite/methods_string"
require "extcite/version"


require 'serrano'
require 'pdf-reader'
require 'faraday'



module Extcite
  ##
  # Extract DOIs from one or more PDFs
  #
  # @param path [String] Path to a pdf file, or a folder of PDF files
  # @param file [String] File name to write data to - or nil to stdout
  # @param output [String] Typeo of output. only bibtex for now
  #
  # Return: writes bib files to a .bib file or an array if file is nil
  #  When writing to a file, `extract` by default appends to the end
  #  of the file so you can build up your bibtex file with your
  #  citations
  #
  # @example
  #   require 'extcite'
  #   require 'faraday'
  #   # get a paper in pdf format
  #   path = '2068.pdf'
  #   res = Faraday.new(:url => "https://peerj.com/articles/2068.pdf").get
  #   f = File.new(path, "wb")
  #   f.write(res.body)
  #   f.close()
  #   # extract doi from the pdf
  #   Extcite.extract(path: path)
  #   Extcite.extract(path: path, file: nil)
  def self.extract(path:, file: "out.bib", output: "bib")
    path = make_paths(path)
    path.each do |x|
      # try PDF metadata first
      ids = nil
      rr = PDF::Reader.new(x)
      pdfmeta = rr.metadata
      if !pdfmeta.nil?
        xml = Oga.parse_xml(pdfmeta)
        begin
          tt = xml.xpath('//rdf:Description')
          # try dc:identifier attribute
          ss = tt.attr('dc:identifier')[0]
          if !ss.nil?
            ids = ss.text.sub(/doi:/, '')
          else
            # try prism:doi node
            pdoi = xml.xpath('//rdf:Description//prism:doi')
            if pdoi.length == 1
              ids = pdoi.text
            else
              # try pdf:WPS-ARTICLEDOI node
              wpsdoi = xml.xpath('//rdf:Description//pdf:WPS-ARTICLEDOI')
              if wpsdoi.length == 1
                ids = wpsdoi.text
              else
                # try pdfx:WPS-ARTICLEDOI node
                pdfxwpsdoi = xml.xpath('//rdf:Description//pdfx:WPS-ARTICLEDOI')
                if pdfxwpsdoi.length == 1
                  ids = pdfxwpsdoi.text
                else
                  ids = nil
                end
              end
            end
          end
        rescue
          ids = nil
        end
      end

      # if not found, try regexing for DOI
      if ids.nil?
        ids = Extcite.get_ids(txt: Extcite.extract_text_one(x))
      end

      if ids.length == 0
        puts "no DOI found in " + x
      else
        if !ids.match(/arxiv/i).nil?
          conn = Faraday.new(:url => 'http://export.arxiv.org/api/query?id_list=' + ids.gsub(/arxiv:/i, '')).get
          bibs = conn.body.make_bib_arxiv(ids.gsub(/arxiv:/i, ''))
        else
          bibs = Extcite.cont_neg(ids: ids)
        end

        # if an error or not found, skip
        bibstest = nil
        if bibs.class == Array
          bibstest = bibs[0]
        end

        if !bibstest.nil?
          if !bibstest.match(/error|not found/i).nil?
            raise "DOI found: " + ids + " ; but citation not found via content negotation - quitting"
            # do something else?
          end
        end

        if file.nil?
          return bibs
        else
          puts "writing " + ids + " to " + file
          bibs.write_bib(file)
        end
      end
    end
  end

  ##
  # Extract DOIs from one or more PDFs after extracting text
  #
  # @param path [String] Path to a pdf file, or a folder of PDF files
  #
  # @example
  #   require 'extcite'
  #   require 'faraday'
  #   # get a paper in pdf format
  #   path = '2068.pdf'
  #   res = Faraday.new(:url => "https://peerj.com/articles/2068.pdf").get
  #   f = File.new(path, "wb")
  #   f.write(res.body)
  #   f.close()
  #   # extract doi from the pdf
  #   Extcite.extract_dois(path: path)
  def self.extract_dois(path:)
    txt = Extcite.extract_text(path: path)
    return txt.map { |z| z.match("[0-9]+\\.[0-9]+/.+").to_s.gsub(/\s.+/, '') }
  end

  ##
  # Get DOIs from a String or Array of String's
  #
  # @param txt [String] String or Array of String's
  #
  # Return: Array of DOIs
  #
  # @example
  #   require 'extcite'
  #   Extcite.get_ids(txt: '10.1016/j.dendro.2014.01.004 adfasdf asd fas df asdfsd')
  def self.get_ids(txt:)
    # see if there's

    return Array(txt).map { |z|
      # detect if is an arxiv paper
      if !z.match(/arxiv:[0-9]+\.[0-9A-Za-z]+/i).nil?
        # if so, return arxiv id for later extraction of arxiv citation via their API
        z = z.match(/arxiv:[0-9]+\.[0-9A-Za-z]+/i).to_s
      else
        doi_pattern = '(10[.][0-9]{4,}(?:[.][0-9]+)*/(?:(?![%"#? ])\\S)+)'
        z = z.match(doi_pattern).to_s.gsub(/\s.+/, '')
        # z = z.match("10\\.[0-9]+/.+").to_s.gsub(/\s.+/, '')
      end
      # clean up doi
      z = z.gsub(/\.$|\.;$|\.\]$|\.\}$|\.\)$|,$/, '')
      return z.gsub(/;$|\]$|\}$|\)$/, '')
    }[0]
  end

  ##
  # Extract text from a pdf, or many pdfs
  #
  # @param path [String] Path to a pdf file, or a folder of PDF files
  #
  # This method is used internally within fetch to parse PDFs.
  #
  # @example
  #   require 'extcite'
  #   require 'faraday'
  #   # get a paper in pdf format
  #   path = '2068.pdf'
  #   res = Faraday.new(:url => "https://peerj.com/articles/2068.pdf").get
  #   f = File.new(path, "wb")
  #   f.write(res.body)
  #   f.close()
  #   # extract doi from the pdf
  #   Extcite.extract_text(path: path)
  def self.extract_text(path:)
    path = Array(path)
    if path.length == 1
      if File.directory?(path[0])
        # keep only files with .pdf extension
        path = dir_files(path[0]).keep_if { |z| !!z.match(/.pdf/) }
      end
    end

    out = []
    path.each do |x|
      rr = PDF::Reader.new(x)
      out << rr.pages.map { |page| page.text }.join("\n")
    end
    return out
  end

  ##
  # Get citation(s) using Crossref content negotation
  #
  # @param ids [Array[String]] One or more DOIs in an array
  #
  # Return: an array of bib data
  #
  # @example
  #   require 'extcite'
  #   Extcite.cont_neg(ids: "10.1016/j.dendro.2014.01.004")
  def self.cont_neg(ids:)
    out = Serrano.content_negotiation(ids: ids)
    return out
  end

  protected

  def self.extract_text_one(x)
    rr = PDF::Reader.new(x)
    return rr.pages.map { |page| page.text }.join("\n")
  end

end
