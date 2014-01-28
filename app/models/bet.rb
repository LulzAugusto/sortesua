# encoding: utf-8

require './lib/numbers_handler'

class Bet < ActiveRecord::Base
  include NumbersHandler
  
  belongs_to :user
  belongs_to :lotto_type
  
  validates :numbers, :user_id, :lotto_type_id, :presence => true
  validates :numbers, :format => { :with => /\A[0-9,]+\z/, :message => "apenas números e vírgulas são permitidos" }
  
  before_save :normalize_numbers # NumbersHandler method
  after_find :split_numbers # NumbersHandler method
  after_save :split_numbers
  
  def last_result
    type = self.lotto_type

    if type.name == 'Dupla-Sena'
      results = type.results.limit(2).order('contest DESC')
      hits = [count_hits(numbers, results[0].numbers), count_hits(numbers, results[1].numbers)]
    else
      result = type.results.limit(1).order('contest DESC')[0]
      hits = count_hits(numbers, result.numbers)
    end

    hits
  end

  def last_five_results
    type = self.lotto_type
    results = [[], []]

    if type.name == 'Dupla-Sena'
      contests = type.results.limit(12).order('contest DESC')
      2.times { contests.delete_at(0) }
      contests.size.times do |i|
        unless i.even?
          results[0] << contests[i].contest
          results[1] << [count_hits(numbers, contests[i-1].numbers), count_hits(numbers, contests[i].numbers)]
        end
      end
    else
      contests = type.results.limit(6).order('contest DESC')
      contests.delete_at(0)
      contests.each do |con|
        results[0] << con.contest
        results[1] << count_hits(numbers, con.numbers)
      end
    end

    results
  end

  def type_matches?(id)
    return true if id == self.lotto_type_id
  end
  
  def show_numbers
    self.numbers.join(' - ')
  end

  private
  def count_hits(betnum, resnum)
    hits = 0
    betnum.each do |num|
      hits += 1 if resnum.include?(num)
    end

    hits
  end
end
