class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :api

  def api
    @api = EdmundsApi.new
  end

end
