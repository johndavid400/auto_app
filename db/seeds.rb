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


# seed db with makes and models
  base = "http://api.edmunds.com/v1/api"
  url = "/vehicle/makerepository/findall?fmt=json&api_key=#{ENV["EDMUNDS_VEHICLE"]}"
  base_url = base + url
  resp = RestClient.get(base_url)
  json = Crack::JSON.parse(resp)
  brands =  json.first.last
  brands.each do |make|
    Make.create name: make["name"], edmunds_make_id: make["id"]
    puts "created #{make["name"]}"
  end


#  Make.all.each do |make|
#    # get models for each make
#    base = "http://api.edmunds.com/v1/api"
#    url = "/vehicle/modelrepository/findbymakeid?makeid=#{make.edmunds_make_id}&fmt=json&api_key=#{ENV["EDMUNDS_VEHICLE"]}"
#    base_url = base + url
#    resp = RestClient.get(base_url)
#    json = Crack::JSON.parse(resp)
#
#    models =  json.first.last
#    models.each do |model|
#      binding.pry
#    end
#
#  end

