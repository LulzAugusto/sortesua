require 'test_helper'

class LottoTypeTest < ActiveSupport::TestCase
  test "association with results and bets" do
    type = lotto_types(:mega)
    
    assert_instance_of Bet, type.bets.first
    assert_instance_of Result, type.results.first
  end
end
