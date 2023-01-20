class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails - Victor Correa [COOKIE]"
    session[:curso] = "Curso de Ruby on Rails - Victor Correa [SESSION]"
    @meu_nome = params[:nome]
    @curso = params[:curso]
  end
end