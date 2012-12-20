require 'spec_helper'

describe "makes/new" do
  before(:each) do
    assign(:make, stub_model(Make,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new make form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => makes_path, :method => "post" do
      assert_select "input#make_name", :name => "make[name]"
    end
  end
end
