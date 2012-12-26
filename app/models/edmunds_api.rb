class EdmundsAPI
  # Using this model requires setting your Edmunds API key in your ~/.bashrc file like so:
  # export EDMUNDS_VEHICLE="your_api_key_here"

  require 'rest_client'
  require 'crack'
  require 'crack/json'

  attr_reader :name, :id

  def initialize
    @base = "http://api.edmunds.com/v1/api"
    @api_key = ENV["EDMUNDS_VEHICLE"]
    @image_base_url = "http://media.ed.edmunds-media.com"
  end

  def get_stuff
    @base_url = @base + @url
    @resp = RestClient.get(@base_url)
    @json = Crack::JSON.parse(@resp)
  end

  def get_makes
    @url = "/vehicle/makerepository/findall?fmt=json&api_key=#{@api_key}"
    get_stuff
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
    get_stuff
    @models = []
    models =  @json.first.last
    models.each do |model|
      @model = model
      if new_models_only == "true"
        if model["subModels"]["NEW"].present?
          @sample_style_id = model["subModels"]["NEW"].first["styleIds"].first
          add_model
        end
      else
        if model["subModels"]["NEW"].present?
          @sample_style_id = model["subModels"]["NEW"].first["styleIds"].first
        elsif model["subModels"]["PRE_PROD"].present?
          @sample_style_id = model["subModels"]["PRE_PROD"].first["styleIds"].first
        elsif model["subModels"]["NEW_USED"].present?
          @sample_style_id = model["subModels"]["NEW_USED"].first["styleIds"].first
        else
          @sample_style_id = model["subModels"]["USED"].first["styleIds"].first
        end
        add_model
      end
    end
    return @models
  end

  def add_model
    @url = "/vehiclephoto/service/findphotosbystyleid?styleId=#{@sample_style_id}&fmt=json&api_key=#{@api_key}"
    get_stuff
    image_face = @json.select{|s| s["subType"] == "exterior" && s["shotTypeAbbreviation"] == "FQ" }.first["photoSrcs"].first
    image = @image_base_url + image_face
    @models.push(name: @model["name"], id: @model["id"], image: image)
  end

end
