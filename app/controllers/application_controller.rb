class ApplicationController < ActionController::Base
  helper_method :current_user, :current_repo, :github

  def current_user
    @current_user ||= github.users.get if github
  end

  def current_repo
    session[:repo]
  end

  def github
    @github ||= Github.new oauth_token: session[:token] if session[:token]
  end
end
