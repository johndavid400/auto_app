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

  def get_models(make_id, new_models_only)
    @make_id = make_id
    @url = "/vehicle/modelrepository/findbymakeid?makeid=#{@make_id}&fmt=json&api_key=#{@api_key}"
    call_api
    @models = []
    models =  @json.first.last
    models.each do |model|
      @model = model
      if new_models_only == "true"
        if model["subModels"]["NEW"].present?
          @style_id = model["subModels"]["NEW"].first["styleIds"].first
          add_model(@style_id)
        end
      else
        if model["subModels"]["NEW"].present?
          @style_id = model["subModels"]["NEW"].first["styleIds"].first
        elsif model["subModels"]["PRE_PROD"].present?
          @style_id = model["subModels"]["PRE_PROD"].first["styleIds"].first
        elsif model["subModels"]["NEW_USED"].present?
          @style_id = model["subModels"]["NEW_USED"].first["styleIds"].first
        else
          @style_id = model["subModels"]["USED"].first["styleIds"].first
        end
        add_model(@style_id)
      end
    end
    return @models
  end

  def add_model(style_id)
    get_image(style_id)
    @models.push(name: @model["name"], id: @model["id"], image: @image)
  end

  def get_image(style_id)
    @url = "/vehiclephoto/service/findphotosbystyleid?styleId=#{style_id}&fmt=json&api_key=#{@api_key}"
    call_api
    begin
      image_face = @json.select{|s| s["subType"] == "exterior" && s["shotTypeAbbreviation"] == "FQ" }.first["photoSrcs"].first
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
        link = @image_base_url + image["photoSrcs"].sample
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
      @model_years.push(year: model_year["year"], id: model_year["id"], image: @image)
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
      @trims.push(style: trim["id"], name: trim["attributeGroups"]["MAIN"]["attributes"]["NAME"]["value"], image: @image)
    end
    return @trims
  end

  def get_trim(trim_id)
    @url = "/vehicle/stylerepository/findbyid?id=#{trim_id}&fmt=json&api_key=#{@api_key}"
    call_api
    return @json["styleHolder"]
  end

end
