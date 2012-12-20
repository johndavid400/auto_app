require 'spec_helper'

describe "makes/edit" do
  before(:each) do
    @make = assign(:make, stub_model(Make,
      :name => "MyString"
    ))
  end

  it "renders the edit make form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => makes_path(@make), :method => "post" do
      assert_select "input#make_name", :name => "make[name]"
    end
  end
end
