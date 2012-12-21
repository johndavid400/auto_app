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


  if Make.all.empty?
    seed db with makes and models
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
            @model.trims.create name: submodel["name"], submodel_id: submodel["id"], style_id: submodel["styleIds"].first
          end
        rescue
          binding.pry
        end
      end
    else
      puts "Gooday mate"
    end
  end


