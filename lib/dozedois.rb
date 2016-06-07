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
  def self.doze(path:, file: "out.bib", output: "bib")
    res = Dozedois.get_dois(path: path)
    bibs = Dozedois.cont_neg(ids: res)
    bibs.write_bib(file)
    puts "bib data written to " + file
  end

  ##
  # Extract DOIs from one or more PDFs
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
  #   Dozedois.get_dois(path: path)
  def self.get_dois(path:)
    txt = Dozedois.extract_text(path: path)
    return txt.map { |z| z.match("[0-9]+\\.[0-9]+/.+").to_s.gsub(/\s.+/, '') }
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
        path = dir_files(path[0])
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

end
