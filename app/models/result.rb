# encoding: utf-8

require './lib/numbers_handler'
require 'mechanize'

class Result < ActiveRecord::Base
  include NumbersHandler
  
  $agent = Mechanize.new
  
  belongs_to :lotto_type
  
  validates :numbers, :contest, :lotto_type_id, :presence => true
  
  before_save :normalize_result_numbers
  after_find :split_numbers # NumbersHandler method
  after_save :split_numbers
  
  def self.updates_lotofacil
    brazilian_time = Time.now - 10800
    if brazilian_time.monday? or brazilian_time.wednesday? or brazilian_time.friday?
      numbers = []
      page = $agent.get('http://www1.caixa.gov.br/loterias/loterias/lotofacil/lotofacil_pesquisa_new.asp')
      values = page.body.split('|')[3..17]
      numbers << values.map {|num| num.to_i}
      contest = page.body.split('|')[0].to_i

      update!('Lotofácil', contest, numbers)
    else
      puts "Not today."
    end
  end

  def self.updates_duplasena
    brazilian_time = Time.now - 10800
    if brazilian_time.tuesday? or brazilian_time.friday?
      numbers = [[], []]
      page = $agent.get('http://www1.caixa.gov.br/loterias/loterias/duplasena/duplasena_pesquisa_new.asp')
      contest = page.body.split('|')[0].to_i
      search = page.search('li')
      0.upto(11) do |i|
        if i < 6
          numbers[0] << search[i].text.to_i
        else
          numbers[1] << search[i].text.to_i
        end
      end

      update!('Dupla-Sena', contest, numbers)
    else
      puts "Not today."
    end
  end

  def self.updates_lotomania
    brazilian_time = Time.now - 10800
    if brazilian_time.wednesday? or brazilian_time.saturday?
      numbers = []
      page = $agent.get('http://www1.caixa.gov.br/loterias/loterias/lotomania/_lotomania_pesquisa.asp')
      contest = page.body.split('|')[0].to_i
      values = page.body.split('|')[6..25]
      numbers << values.map { |num| num.to_i }
      
      update!('Lotomania', contest, numbers)
    else
      puts 'Not Today.'
    end
  end

  def self.update!(typename, contest, numbers)
    type = LottoType.find_by_name("#{typename}")
    last_result = type.results.limit(1).order('contest DESC')[0]

    numbers.each do |numbers|
      if last_result.contest < contest
        result = type.results.new
        result.numbers = numbers
        result.contest = contest
        result.save if result.valid?
        puts "Updated!"
      else
        puts "Already updated."
        break
      end
    end
  end
  
end
