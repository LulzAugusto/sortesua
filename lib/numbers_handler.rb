# encoding: utf-8

module NumbersHandler
  def normalize_numbers
    self.numbers.gsub!(',', '-')
  end
  
  def normalize_result_numbers
    self.numbers = numbers.join('-')
  end
  
  def split_numbers
    self.numbers = numbers.split('-').collect! { |v| v = v.to_i }
  end
  
  def validate_numbers
    if numbers.is_a?(Array)
      numbers.each { |v| errors.add(:numbers, "não é um número") unless v.is_a?(Fixnum) }
    else
      errors.add(:numbers, "não é um array")
    end
  end
end