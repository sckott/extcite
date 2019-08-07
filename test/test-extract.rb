require_relative 'test_helper'

class TestExtract < Test::Unit::TestCase

  def setup
    @path = 'test/pdfs/White2015IdeasEcolEvol.pdf'
  end

  def test_extract_to_file
    res = Extcite.extract(path: @path)

    assert_equal(Array, res.class)
    assert_equal(1, res.length)
    assert_equal(String, res[0].class)
    assert_false(res[0].match(/pdf/).nil?)
  end

  def test_extract_stdout
    res = Extcite.extract(path: @path, file: nil)

    assert_equal(String, res.class)
    assert_true(res.length > 1)
    assert_equal(String, res[0].class)
    assert_true(res[0].match(/Ethan White/).nil?)
    assert_true(res[0].match(/Ecology/).nil?)
    assert_true(res[0].match(/Some thoughts on best publishing practices/).nil?)
  end

end
