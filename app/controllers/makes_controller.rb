class MakesController < ApplicationController

  def index
    @new_makes = @api.get_makes
    @makes = Make.all
    @models = [{:name => "please select a make"}, {:id => "0"}]
  end

  def show
    @make = Make.find(params[:id])
  end

  def get_models
    @models = @api.get_models(params[:id], params[:new], true)
    @make_id = params[:id]
    params[:new] == "true" ? @msg = "Viewing New Models Only" : @msg = "Viewing All Models"
  end

  def autofill_models
    @models = @api.get_models(params[:id])
  end

end
