require_relative 'test_helper'

class TestExtractTextOne < Test::Unit::TestCase

  def setup
    @path = 'test/pdfs/CinelliEtal2020arxiv.pdf'
  end

  def test_extract_text_one
    res = Extcite.extract_text_one(@path)

    assert_equal(String, res.class)
    assert_true(res.length > 1000)
    assert_false(res.match(/interconnectedness/).nil?)
  end

end
