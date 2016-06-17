require 'faraday'
require 'serrano'
require 'pdf-reader'
require "dozedois/utils"
require "dozedois/methods_array"
require "dozedois/methods_string"
require "dozedois/version"

module Dozedois
  ##
  # Extract DOIs from one or more PDFs
  #
  # @param path [String] Path to a pdf file, or a folder of PDF files
  # @param file [String] File name to write data to
  # @param output [String] One of: "bibtex" (only bibtex for now)
  #
  # Return: writes bib files to a .bibtex file
  #
  # @example
  #   require 'dozedois'
  #   require 'faraday'
  #   # get a paper in pdf format
  #   path = '2068.pdf'
  #   res = Faraday.new(:url => "https://peerj.com/articles/2068.pdf").get
  #   f = File.new(path, "wb")
  #   f.write(res.body)
  #   f.close()
  #   # extract doi from the pdf
  #   Dozedois.doze(path: path)
  def self.doze(path:, file: "out.bib", output: "bib", iterate: true)
    if iterate
      path = make_paths(path)
      out = []
      path.each do |x|
        ids = Dozedois.get_ids(txt: Dozedois.extract_text_one(x))
        if ids.length == 0
          puts "no DOI found in " + x
        else
          if !ids.match(/arxiv/i).nil?
            conn = Faraday.new(:url => 'http://export.arxiv.org/api/query?id_list=' + ids.gsub(/arxiv:/i, '')).get
            bibs = conn.body.make_bib_arxiv(ids.gsub(/arxiv:/i, ''))
          else
            bibs = Dozedois.cont_neg(ids: ids)
          end
          bibs.write_bib(file)
          puts "writing " + ids
        end
      end
    else
      res = Dozedois.extract_dois(path: path)
      bibs = Dozedois.cont_neg(ids: res)
      bibs.write_bib(file)
      puts "bib data written to " + file
    end
  end

  ##
  # Extract DOIs from one or more PDFs after extracting text
  #
  # @param path [String] Path to a pdf file, or a folder of PDF files
  #
  # @example
  #   require 'dozedois'
  #   require 'faraday'
  #   # get a paper in pdf format
  #   path = '2068.pdf'
  #   res = Faraday.new(:url => "https://peerj.com/articles/2068.pdf").get
  #   f = File.new(path, "wb")
  #   f.write(res.body)
  #   f.close()
  #   # extract doi from the pdf
  #   Dozedois.extract_dois(path: path)
  def self.extract_dois(path:)
    txt = Dozedois.extract_text(path: path)
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
  #   require 'dozedois'
  #   Dozedois.get_ids(txt: '10.1016/j.dendro.2014.01.004 adfasdf asd fas df asdfsd')
  def self.get_ids(txt:)
    return Array(txt).map { |z|
      # detect if is an arxiv paper
      if !z.match(/arxiv:[0-9]+\.[0-9A-Za-z]+/i).nil?
        # if so, return arxiv id for later extraction of arxiv citation via their API
        z = z.match(/arxiv:[0-9]+\.[0-9A-Za-z]+/i).to_s
      else
        z = z.match("[0-9]+\\.[0-9]+/.+").to_s.gsub(/\s.+/, '')
      end
      # clean up doi
      z = z.gsub(/\.$|\.;$|\.\]$|\.\}$|\.\)$/, '')
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
  #   require 'dozedois'
  #   require 'faraday'
  #   # get a paper in pdf format
  #   path = '2068.pdf'
  #   res = Faraday.new(:url => "https://peerj.com/articles/2068.pdf").get
  #   f = File.new(path, "wb")
  #   f.write(res.body)
  #   f.close()
  #   # extract doi from the pdf
  #   Dozedois.extract_text(path: path)
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
  #   require 'dozedois'
  #   Dozedois.cont_neg(ids: "10.1016/j.dendro.2014.01.004")
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
