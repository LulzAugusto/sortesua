class LottoType < ActiveRecord::Base
  has_many :bets, :dependent => :nullify
  has_many :results, :dependent => :nullify
end
