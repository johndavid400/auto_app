require "spec_helper"

describe TrimsController do
  describe "routing" do

    it "routes to #index" do
      get("/trims").should route_to("trims#index")
    end

    it "routes to #new" do
      get("/trims/new").should route_to("trims#new")
    end

    it "routes to #show" do
      get("/trims/1").should route_to("trims#show", :id => "1")
    end

    it "routes to #edit" do
      get("/trims/1/edit").should route_to("trims#edit", :id => "1")
    end

    it "routes to #create" do
      post("/trims").should route_to("trims#create")
    end

    it "routes to #update" do
      put("/trims/1").should route_to("trims#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/trims/1").should route_to("trims#destroy", :id => "1")
    end

  end
end
