class EdmundsAPI
  # Using this model requires setting your Edmunds API key in your ~/.bashrc file like so:
  # export EDMUNDS_VEHICLE="your_api_key_here"

  require 'rest_client'
  require 'crack'
  require 'crack/json'

  attr_reader :data, :image, :images

  def initialize
    @base = "http://api.edmunds.com/v1/api"
    @api_key = ENV["EDMUNDS_VEHICLE"]
    @image_base_url = "http://media.ed.edmunds-media.com"
  end

  def call_api
    @base_url = @base + @url
    @resp = RestClient.get(@base_url)
    @json = Crack::JSON.parse(@resp)
  end

  def get_makes
    @url = "/vehicle/makerepository/findall?fmt=json&api_key=#{@api_key}"
    call_api
    @makes = []
    manufacturers =  @json.first.last
    manufacturers.each do |make|
      @makes.push(name: make["name"], id: make["id"])
    end
    return @makes
  end

  def get_models(make_id, new_models_only, image_true_false)
    @image_true_false = image_true_false
    @make_id = make_id
    @url = "/vehicle/modelrepository/findbymakeid?makeid=#{@make_id}&fmt=json&api_key=#{@api_key}"
    call_api
    @models = []
    if new_models_only == "1"
      mdls = @json.first.last.select{|s| s["subModels"]["NEW"] }
    else
      mdls =  @json.first.last
    end
    mdls.each do |model|
      @model = model
      @style_id = model["subModels"].first.last.first["styleIds"].first
      add_model
    end
    return @models
  end

  def add_model
    if @image_true_false
      get_image(@style_id)
      @models.push(name: @model["name"], id: @model["id"], image: @image)
    else
      @models.push(name: @model["name"], id: @model["id"])
    end
  end

  def get_image(style_id)
    @url = "/vehiclephoto/service/findphotosbystyleid?styleId=#{style_id}&fmt=json&api_key=#{@api_key}"
    call_api
    begin
      image_face = @json.select{|s| s["subType"] == "exterior" && s["shotTypeAbbreviation"] == "FQ" }.first["photoSrcs"].select{|s| s.match(/\d{3}(.jpg)/) }.max
      @image = @image_base_url + image_face
    rescue
      @image = "http://client.amarablack.com/bandladder/sites/default/files/users/images/800px-No_Image_Wide.svg_.png"
    end
    return @image
  end

  def get_images(style_id)
    @url = "/vehiclephoto/service/findphotosbystyleid?styleId=#{style_id}&fmt=json&api_key=#{@api_key}"
    call_api
    begin
      @images = []
      @json.each do |image|
        link = @image_base_url + image["photoSrcs"].select{|s| s.match(/\d{3}(.jpg)/) }.max
        @images.push(link: link, caption: image["captionTranscript"], order: image["vdpOrder"])
      end
    rescue
      @images = ["http://client.amarablack.com/bandladder/sites/default/files/users/images/800px-No_Image_Wide.svg_.png"]
    end
    return @images
  end

  def get_model_years(model_id)
    @model_id = model_id
    @url = "/vehicle/modelrepository/findbyid?id=#{@model_id}&fmt=json&api_key=#{@api_key}"
    call_api
    @model_years = []
    models =  @json.first.last
    models.first["modelYears"].each do |model_year|
      @model_year = model_year["id"]
      @url = "/vehicle/stylerepository/findstylesbymodelyearid?modelyearid=#{@model_year}&fmt=json&api_key=#{@api_key}"
      call_api
      get_image(@json["styleHolder"].first["id"])
      @model_years.push(year: model_year["year"], id: model_year["id"], image: @image, name: "#{models.first["makeName"]} #{models.first["name"]}")
    end
    return @model_years
  end

  def get_trims(model_year_id)
    @url = "/vehicle/stylerepository/findstylesbymodelyearid?modelyearid=#{model_year_id}&fmt=json&api_key=#{@api_key}"
    call_api
    trims = @json["styleHolder"]
    get_image(trims.sample["id"])
    @trims = []
    trims.each do |trim|
      @trims.push(style: trim["id"], name: "#{trim["year"]} #{trim["attributeGroups"]["MAIN"]["attributes"]["NAME"]["value"]}", image: @image)
    end
    return @trims
  end

  def get_trim(trim_id)
    @url = "/vehicle/stylerepository/findbyid?id=#{trim_id}&fmt=json&api_key=#{@api_key}"
    call_api
    return @json["styleHolder"]
  end

end
