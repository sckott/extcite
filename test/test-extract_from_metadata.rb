require_relative 'test_helper'

class TestExtractFromMetadata < Test::Unit::TestCase

  def setup
    @path = 'test/pdfs/White2015IdeasEcolEvol.pdf'
  end

  def test_extract_from_metadata
    res = Extcite.extract_from_metadata(path: @path)

    assert_equal(String, res.class)
    assert_equal(22, res.length)
    assert_false(res.match(/10.4033/).nil?)
  end

end
