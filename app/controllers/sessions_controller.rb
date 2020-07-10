class SessionsController < ApplicationController
  def new
    if params[:code]
      session[:token] = GITHUB.get_token(params[:code]).token
      redirect_to :root_url
    end
  end
end