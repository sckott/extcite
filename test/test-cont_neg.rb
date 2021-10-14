require_relative 'test_helper'

class TestContNeg < Test::Unit::TestCase

  def test_cont_neg
    res = Extcite.cont_neg(ids: "10.1002/ece3.8055")

    if res.class == Array
        res = res[0]
    end

    assert_equal(String, res.class)
    assert_false(res.match(/Wiley/).nil?)
    assert_false(res.match(/Guzman/).nil?)
    assert_false(res.match(/robustness/).nil?)
  end

end
