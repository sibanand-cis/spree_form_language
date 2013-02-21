require 'spec_helper'

describe "forms/index" do
  before(:each) do
    assign(:forms, [
      stub_model(Form,
        :form_name => "Form Name"
      ),
      stub_model(Form,
        :form_name => "Form Name"
      )
    ])
  end

  it "renders a list of forms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Form Name".to_s, :count => 2
  end
end
