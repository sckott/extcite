require_relative 'test_helper'

class TestExtractDois < Test::Unit::TestCase

  def setup
    @path = 'test/pdfs/White2015IdeasEcolEvol.pdf'
  end

  def test_extract_text
    res = Extcite.extract_dois(path: @path)

    assert_equal(Array, res.class)
    assert_equal(1, res.length)
    assert_equal(String, res[0].class)
    assert_false(res[0].match('(10[.][0-9]{4,}(?:[.][0-9]+)*/(?:(?![%"#? ])\\S)+)').nil?)
  end

end
