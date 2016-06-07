##
# Thin layer around pdf-reader gem's PDF::Reader
#
# @param doi [Array] A DOI, digital object identifier
# @param type [Array] One of two options to download: xml (default) or pdf
#
# @example
#     require 'textminer'
#     # fetch full text by DOI - xml by default
#     Textminer.fetch("10.3897/phytokeys.42.7604")
#     # many DOIs - xml output
#     res = Textminer.fetch(["10.3897/phytokeys.42.7604", "10.3897/zookeys.516.9439"])
#     # fetch full text - pdf
#     Textminer.fetch("10.3897/phytokeys.42.7604", "pdf")
def self.fetch(doi, type = 'xml')
  Fetch.new(doi, type).fetchtext
end
