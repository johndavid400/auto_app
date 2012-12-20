require 'spec_helper'

describe "makes/show" do
  before(:each) do
    @make = assign(:make, stub_model(Make,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
