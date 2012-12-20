require 'spec_helper'

describe "trims/show" do
  before(:each) do
    @trim = assign(:trim, stub_model(Trim,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
