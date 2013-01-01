class ModelsController < ApplicationController

  def index
    @models = Model.order('name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @models }
    end
  end

  def show
    @model = Model.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @model }
    end
  end

  def get_trims
    @model_id = params[:id]
    model_years
  end

  def model_years
    @model_id = params[:model] unless @model_id
    @model_years = @api.get_model_years(@model_id)
    @model = @model_years.first[:name]
  end
end
