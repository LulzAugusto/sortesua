module BetsHelper
  def submit_or_cancel(form, name='Cancel')
    if @bet.numbers.nil?
      return form.submit('Criar', :class => 'btn btn-primary') + ' ' + link_to('Cancelar', cancel_path(:format => :js), :remote => true, :class => 'cancel btn')
    else
      return form.submit('Atualizar', :class => 'btn btn-primary') + ' ' + link_to('Cancelar', cancel_path(:format => :js), :remote => true, :class => 'cancel btn')
    end
  end

  def show_result(bet)
  	if bet.lotto_type.name == 'Dupla-Sena'
  		return bet.last_result[0].to_s + ' e ' + bet.last_result[1].to_s
  	else
  		return bet.last_result.to_s
  	end
  end

  def show_last_five_results(result, i)
    if result[1][0].is_a? Array
      return result[1][i][0].to_s + ' e ' + result[1][i][1].to_s
    else
      return result[1][i]
    end
  end
end
