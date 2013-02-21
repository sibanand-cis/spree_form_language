require 'spec_helper'

describe "forms/new" do
  before(:each) do
    assign(:form, stub_model(Form,
      :form_name => "MyString"
    ).as_new_record)
  end

  it "renders new form form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forms_path, :method => "post" do
      assert_select "input#form_form_name", :name => "form[form_name]"
    end
  end
end
