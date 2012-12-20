require "spec_helper"

describe MakesController do
  describe "routing" do

    it "routes to #index" do
      get("/makes").should route_to("makes#index")
    end

    it "routes to #new" do
      get("/makes/new").should route_to("makes#new")
    end

    it "routes to #show" do
      get("/makes/1").should route_to("makes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/makes/1/edit").should route_to("makes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/makes").should route_to("makes#create")
    end

    it "routes to #update" do
      put("/makes/1").should route_to("makes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/makes/1").should route_to("makes#destroy", :id => "1")
    end

  end
end
