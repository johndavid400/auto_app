require 'spec_helper'

describe "trims/new" do
  before(:each) do
    assign(:trim, stub_model(Trim,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new trim form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => trims_path, :method => "post" do
      assert_select "input#trim_name", :name => "trim[name]"
    end
  end
end
