require 'spec_helper'

describe "forms/edit" do
  before(:each) do
    @form = assign(:form, stub_model(Form,
      :form_name => "MyString"
    ))
  end

  it "renders the edit form form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forms_path(@form), :method => "post" do
      assert_select "input#form_form_name", :name => "form[form_name]"
    end
  end
end
