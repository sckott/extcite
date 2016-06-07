require 'simplecov'
SimpleCov.start
if ENV['CI']=='true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require "dozedois"
require 'fileutils'
require "test/unit"

class TestContneg < Test::Unit::TestCase

  def setup
    @doi1 = "10.1016/j.dendro.2014.01.004"
    @doi2 = '10.5555/515151'
    @doi3 = "10.3897/phytokeys.42.7604"
  end

  def test_cont_neg1
    res = Dozedois.cont_neg(ids: @doi1)

    assert_equal(Array, res.class)
    assert_equal(String, res[0].class)
    assert_false(res[0].match(/article/).nil?)
  end

end
