module Textminer
  class Fetch #:nodoc:
      attr_accessor :doi, :type

      def initialize(doi, type)
        self.doi = doi
        self.type = type
      end

      def fetchtext
        lks = Textminer.links(self.doi)
        lk = pick_link(lks)
        case self.type
        when "xml"
          # HTTParty.get(lk)
          coll = []
          Array(lk).each do |x|
            coll << HTTParty.get(x)
          end
          return coll
        when "pdf"
          serialize_pdf(lk, self.doi)
        end
      end

      private

      def pick_link(x)
        case self.type
        when "xml"
          x.xml
        when "pdf"
          x.pdf
        else
          puts "type must be xml or pdf"
        end
      end

      def serialize_pdf(x, y)
        path = "/Users/sacmac/.textminer/" + y.gsub('/', '_') + ".pdf"
        File.open(path, "wb") do |f|
          f.write HTTParty.get(x).parsed_response
        end

        return path
      end

    end
end
