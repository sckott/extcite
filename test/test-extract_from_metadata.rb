require_relative 'test_helper'

class TestExtractFromMetadata < Test::Unit::TestCase

  def setup
    @path = 'test/pdfs/White2015IdeasEcolEvol.pdf'
    @path2 = 'test/pdfs/Bramlett&Burge2020Politics&Religion.pdf'
  end

  def test_extract_from_metadata
    res = Extcite.extract_from_metadata(path: @path)

    assert_equal(String, res.class)
    assert_equal(22, res.length)
    assert_false(res.match(/10.4033/).nil?)

    res = Extcite.extract_from_metadata(path: @path2)

    assert_equal(String, res.class)
    assert_equal(res, "10.1017/S1755048320000231")
  end

end
