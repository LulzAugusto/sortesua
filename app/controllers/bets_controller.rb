class BetsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @bets = current_user.bets.all
    
    respond_to do |format|
      format.html
    end
  end
  
  def show
    
  end
  
  def new
    @bet = current_user.bets.new
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @bet = current_user.bets.new(params[:bet])
    
    if @bet.save
      respond_to do |format|
        format.html { redirect_to @bet, :notice => 'Aposta criada' }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :new, :alert => 'Nao foi possivel criar a aposta' }
        format.js { render 'fail_create.js.erb' }
      end
    end
  end

  def show_last_five
    @bet = current_user.bets.find(params[:id])
    @result = @bet.last_five_results
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @bet = current_user.bets.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def update
    @bet = current_user.bets.find(params[:id])
    if @bet.update_attributes(params[:bet])
      respond_to do |format|
        format.html { redirect_to @bet, :alert => 'Aposta atualizada' }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :edit, :alert => 'Nao foi possivel editar a aposta' }
        format.js { render 'fail_create.js.erb' }        
      end
    end
  end
  
  def destroy
    @bet = current_user.bets.find(params[:id])
    @bet.destroy
    respond_to do |format|
      format.html { redirect_to root_path, :alert => 'Aposta apagada' }
      format.js
    end
  end
  
  def cancel
    render 'cancel.js.erb'
  end
end
