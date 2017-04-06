require_relative 'test_helper'
require 'extcite'

class TestContNeg < Test::Unit::TestCase

  def test_cont_neg
    res = Extcite.cont_neg(ids: "10.1016/j.dendro.2014.01.004")

    assert_equal(Array, res.class)
    assert_equal(String, res[0].class)
    assert_false(res[0].match(/Altman_2014/).nil?)
    assert_false(res[0].match(/Dendrochronologia/).nil?)
    assert_false(res[0].match(/TRADER/).nil?)
  end

end
