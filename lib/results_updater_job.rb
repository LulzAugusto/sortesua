require 'mechanize'

class ResultsUpdaterJob
  attr_accessor :result, :contest
  
  $agent = Mechanize.new
  
  def initialize
    @result = []
    @contest = 0
    
    updates_lotofacil
  end
  
  def updates_lotofacil
    page = $agent.get('http://www1.caixa.gov.br/loterias/loterias/lotofacil/lotofacil_pesquisa_new.asp')
    numbers = page.body.split('|')[3..17]
    @result = numbers.map {|num| num.to_i}
    @contest = page.body.split('|')[0].to_i
  end
end