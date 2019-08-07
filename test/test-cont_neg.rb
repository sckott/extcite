require_relative 'test_helper'

class TestContNeg < Test::Unit::TestCase

  def test_cont_neg
    res = Extcite.cont_neg(ids: "10.1016/j.dendro.2014.01.004")

    if res.class == Array
        res = res[0]
    end

    assert_equal(String, res.class)
    assert_false(res.match(/Altman_2014/).nil?)
    assert_false(res.match(/Dendrochronologia/).nil?)
    assert_false(res.match(/TRADER/).nil?)
  end

end
