class MakesController < ApplicationController

  def index
    @makes = @api.get_makes
    @models = [{:name => "please select a make"}, {:id => "0"}]
    @new_makes = @api.get_new_makes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @makes }
    end
  end

  def show
    @make = Make.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @make }
    end
  end

  def get_models
    @models = @api.get_models(params[:id], params[:new], true)
    @make_id = params[:id]
    params[:new] == "true" ? @msg = "Viewing New Models Only" : @msg = "Viewing All Models"
  end

  def autofill_models
    @models = @api.get_models(params[:id], params[:new], false)
  end

end
