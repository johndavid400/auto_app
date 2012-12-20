require 'spec_helper'

describe "trims/edit" do
  before(:each) do
    @trim = assign(:trim, stub_model(Trim,
      :name => "MyString"
    ))
  end

  it "renders the edit trim form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => trims_path(@trim), :method => "post" do
      assert_select "input#trim_name", :name => "trim[name]"
    end
  end
end
