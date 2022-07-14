require 'rails_helper'

RSpec.describe "affiliations/edit", type: :view do
  before(:each) do
    @affiliation = assign(:affiliation, Affiliation.create!(
      name: "MyString"
    ))
  end

  it "renders the edit affiliation form" do
    render

    assert_select "form[action=?][method=?]", affiliation_path(@affiliation), "post" do

      assert_select "input[name=?]", "affiliation[name]"
    end
  end
end
