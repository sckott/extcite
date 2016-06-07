require 'faraday'
require 'serrano'
require 'pdf-reader'
require "dozedois/utils"
require "dozedois/methods_array"
require "dozedois/version"

module Dozedois
  ##
  # Extract DOIs from one or more PDFs
  #
  # @param path [String] Path to a pdf file, or a folder of PDF files
  #
  # @example
  #   require 'dozedois'
  #   require 'faraday'
  #   # get a paper in pdf format
  #   path = 'peerj.pdf'
  #   res = Faraday.new(:url => "https://peerj.com/articles/2068.pdf").get
  #   f = File.new(path, "wb")
  #   f.write(res.body)
  #   f.close()
  #   # extract doi from the pdf
  #   Dozedois.get_dois(path: path)
  def self.get_dois(path:)
    txt = Dozedois.extract_text(path: path)

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
  #   path = 'peerj.pdf'
  #   res = Faraday.new(:url => "https://peerj.com/articles/2068.pdf").get
  #   f = File.new(path, "wb")
  #   f.write(res.body)
  #   f.close()
  #   # extract doi from the pdf
  #   Dozedois.extract_text(path: path)
  def self.extract_text(path:)
    if File.directory?(path)
      path = dir_files(path)
    end
    path = Array(path)
    out = []
    path.each do |x|
      rr = PDF::Reader.new(x)
      out += rr.pages.map { |page| page.text }.join("\n")
    end
  end

  ##
  # Get citation(s) using Crossref content negotation
  #
  # @param dois [Array[String]] One or more DOIs in an array
  # @param output [String] One of: "bibtex" (only bibtex for now)
  #
  # Return: writes bib files to a .bibtex file
  #
  # @example
  #   require 'dozedois'
  #   Dozedois.cont_neg("")
  def self.cont_neg(dois:, file: "out.bib", output: "bib")
    out = Serrano::content_negotiation(ids: dois)
    out.write_bib(file)
    puts "bib written to " + file
  end

end
