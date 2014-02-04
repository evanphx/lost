require 'minitest/autorun'
require 'lost'

class TestLost < MiniTest::Unit::TestCase
  def test_get_twice
    assert Lost.current_position
    assert Lost.current_position
  end
end
