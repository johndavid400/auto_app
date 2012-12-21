# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'rest_client'
require 'crack'
require 'crack/json'


  ####  Check Edmunds for Makes
  if Make.all.empty?
    base = "http://api.edmunds.com/v1/api"
    url = "/vehicle/makerepository/findall?fmt=json&api_key=#{ENV["EDMUNDS_VEHICLE"]}"
    base_url = base + url
    resp = RestClient.get(base_url)
    json = Crack::JSON.parse(resp)
    brands =  json.first.last
    brands.each do |make|
      Make.create name: make["name"], edmunds_id: make["id"]
      puts "created #{make["name"]}"
    end
  end


  ####  Go through each Make, populating each model and trim
  Make.all.each do |make|
    if make.models.empty?
      sleep 1
      @make = make
      # get models for each make
      base = "http://api.edmunds.com/v1/api"
      url = "/vehicle/modelrepository/findbymakeid?makeid=#{make.edmunds_id}&fmt=json&api_key=#{ENV["EDMUNDS_VEHICLE"]}"
      base_url = base + url
      resp = RestClient.get(base_url)
      json = Crack::JSON.parse(resp)

      models =  json.first.last
      models.each do |model|
        begin
          @model = @make.models.create name: model["name"], edmunds_id: model["id"]
          if model["subModels"]["NEW"].present?
            style_id = model["subModels"]["NEW"].first["styleIds"].first
            trim = model["subModels"]["NEW"]
          elsif model["subModels"]["PRE_PROD"].present?
            style_id = model["subModels"]["PRE_PROD"].first["styleIds"].first
            trim = model["subModels"]["PRE_PROD"]
          elsif model["subModels"]["NEW_USED"].present?
            style_id = model["subModels"]["NEW_USED"].first["styleIds"].first
            trim = model["subModels"]["NEW_USED"]
          else
            style_id = model["subModels"]["USED"].first["styleIds"].first
            trim = model["subModels"]["USED"]
          end
          trim.each do |submodel|
            sm_trim = @model.trims.create name: submodel["name"], submodel_id: submodel["id"], style_id: submodel["styleIds"].first
            puts "#{sm_trim.model.make.name}: #{sm_trim.model.name} : #{sm_trim.name}"
          end
        rescue
          binding.pry
        end
      end
    else
      puts "Already have models for: #{make.name}"
    end
  end

  ####  Go through each trim and check for images
  Trim.all.each do |trim|
    if trim.images.empty?
      begin
        sleep 1.5
        base = "http://api.edmunds.com/v1/api"
        url = "/vehiclephoto/service/findphotosbystyleid?styleId=#{trim.style_id}&fmt=json&api_key=#{ENV["EDMUNDS_VEHICLE"]}"
        base_url = base + url
        image_base_url = "http://media.ed.edmunds-media.com"
        resp = RestClient.get(base_url)
        json = Crack::JSON.parse(resp)
        json.each do |image_set|
          image_face = image_set["photoSrcs"].select{|s| /\d{3}(.jpg|.png|.jpeg)/.match(s) }.first
          image = image_base_url + image_face
          trim.images.create link: image, description: image_set["captionTranscript"]
          puts "Found images for: #{trim.model.make.name}: #{trim.model.name} : #{trim.name}"
        end
        puts Image.count
      rescue
        puts "Failed to load image for #{trim.name}"
      end
    else
     puts "Already have images for: #{trim.model.make.name}: #{trim.model.name} : #{trim.name}"
    end
  end


