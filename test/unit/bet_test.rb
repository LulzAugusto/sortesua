# encoding: utf-8
require 'test_helper'

class BetTest < ActiveSupport::TestCase
  test "should create a bet" do
    bet = users(:lulz).bets.new
    bet.lotto_type = lotto_types(:mega)
    bet.numbers = '1, 2, 3, 4, 5, 6'
    
    assert bet.save
  end
  
  test "should not validate a bet without numbers, type nor owner" do
    bet = Bet.new
    bet.numbers = 1312389
    assert !bet.valid?
    assert bet.errors[:user_id].any?
    assert bet.errors[:lotto_type_id].any?
  end
  
  test "should get numbers as an array and number's values as fixnum" do
    bet = Bet.first
    
    assert_instance_of Array, bet.numbers
    bet.numbers.each { |v| assert_instance_of Fixnum, v }
  end
  
  test "should get hits as a fixnum and it should be six" do
    bet = bets(:one)
    assert_instance_of Fixnum, bet.hits
    assert_equal 6, bet.hits
  end
  
  test "should match a fixnum with your own lotto_type_id" do
    bet = bets(:one)
    
    assert bet.type_matches?(bet.lotto_type_id)
  end
end
