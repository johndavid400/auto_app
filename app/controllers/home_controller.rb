class HomeController < ApplicationController
  require 'rest_client'
  require 'crack'
  require 'crack/json'

  def index
    get_vehicle_list
  end

  def get_vehicle_list
    base = "http://api.edmunds.com/v1/api"
    url = "/vehicle/makerepository/findall?fmt=json&api_key=#{ENV["EDMUNDS_VEHICLE"]}"
    base_url = base + url
    resp = RestClient.get(base_url)
    json = Crack::JSON.parse(resp)
    @makes = []
    brands =  json.first.last
    brands.each do |make|
      @makes.push(make["name"])
    end
  end

end
