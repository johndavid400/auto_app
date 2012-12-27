class TrimsController < ApplicationController

  def index
    @trims = Trim.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trims }
    end
  end

  def show
    @trim = Trim.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trim }
    end
  end

  def feature_image
    @image = Image.find(params[:image_id])
    trim = @image.trim
    trim.featured_image = @image.link
    trim.save
    flash[:notice] = "Image set as trim default"
    redirect_to trim_path(trim)
  end

  def get_trims
    model_year_id = params[:id]
    @trims = @api.get_trims(model_year_id)
    @model = @trims.first[:name]
  end

  def get_trim_info
    trim_id = params[:id]
    @trim = @api.get_trim(trim_id)
    @trim_name = @trim.first["attributeGroups"]["MAIN"]["attributes"]["NAME"]["value"]
    @trim.first["attributeGroups"].delete_if{|s| s["TMVU_FEATURE"]}.delete_if{|s| s["MAIN"]}.delete_if{|s| s["LEGACY"]}
    @images = @api.get_images(@trim.first["id"].to_i)
  end

end
