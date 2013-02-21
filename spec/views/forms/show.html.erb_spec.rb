require 'spec_helper'

describe "forms/show" do
  before(:each) do
    @form = assign(:form, stub_model(Form,
      :form_name => "Form Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Form Name/)
  end
end
