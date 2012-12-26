class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :api

  def api
    @api = EdmundsAPI.new
  end

end
