class HomeController < ApplicationController

  def index
    @makes = Make.all
  end

end
