class MakesController < ApplicationController

  def index
    @new_makes = @api.get_makes
    @makes = Make.all
    if params["preference"] == "list"
      render 'list_view'
    else
      render 'block_view'
    end
  end

  def show
    @make = Make.find(params[:id])
  end

  def get_models
    @models = @api.get_models(params[:edmunds_id])
    @make_id = params[:edmunds_id]
    params[:new] == "true" ? @msg = "Viewing New Models Only" : @msg = "Viewing All Models"
  end

  def autofill_models
    @models = @api.get_models(params[:id])
  end

end
