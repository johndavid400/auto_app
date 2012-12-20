require 'spec_helper'

describe "trims/index" do
  before(:each) do
    assign(:trims, [
      stub_model(Trim,
        :name => "Name"
      ),
      stub_model(Trim,
        :name => "Name"
      )
    ])
  end

  it "renders a list of trims" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
