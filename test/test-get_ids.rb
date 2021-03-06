require_relative 'test_helper'

class TestGetIds < Test::Unit::TestCase

  def setup
    @str = '10.1016/j.dendro.2014.01.004 adfasdf asd fas df asdfsd'
  end

  def test_get_ids
    res = Extcite.get_ids(txt: @str)

    assert_equal(String, res.class)
    assert_false(res.match(/10.1016\/j.dendro.2014.01.004/).nil?)
  end

end
