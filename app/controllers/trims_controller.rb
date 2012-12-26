class TrimsController < ApplicationController
  # GET /trims
  # GET /trims.json
  def index
    @trims = Trim.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trims }
    end
  end

  # GET /trims/1
  # GET /trims/1.json
  def show
    @trim = Trim.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trim }
    end
  end

  # GET /trims/new
  # GET /trims/new.json
  def new
    @trim = Trim.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trim }
    end
  end

  # GET /trims/1/edit
  def edit
    @trim = Trim.find(params[:id])
  end

  # POST /trims
  # POST /trims.json
  def create
    @trim = Trim.new(params[:trim])

    respond_to do |format|
      if @trim.save
        format.html { redirect_to @trim, notice: 'Trim was successfully created.' }
        format.json { render json: @trim, status: :created, location: @trim }
      else
        format.html { render action: "new" }
        format.json { render json: @trim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trims/1
  # PUT /trims/1.json
  def update
    @trim = Trim.find(params[:id])

    respond_to do |format|
      if @trim.update_attributes(params[:trim])
        format.html { redirect_to @trim, notice: 'Trim was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trims/1
  # DELETE /trims/1.json
  def destroy
    @trim = Trim.find(params[:id])
    @trim.destroy

    respond_to do |format|
      format.html { redirect_to trims_url }
      format.json { head :no_content }
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
  end

  def get_trim_info
    trim_id = params[:id]
    @trim = @api.get_trim(trim_id)
    @trim_name = @trim.first["attributeGroups"]["MAIN"]["attributes"]["NAME"]["value"]
    @trim.first["attributeGroups"].delete_if{|s| s["TMVU_FEATURE"]}.delete_if{|s| s["MAIN"]}.delete_if{|s| s["LEGACY"]}
    @images = @api.get_images(@trim.first["id"].to_i)
  end

end
