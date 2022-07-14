require 'rails_helper'

RSpec.describe "affiliations/index", type: :view do
  before(:each) do
    assign(:affiliations, [
      Affiliation.create!(
        name: "Name"
      ),
      Affiliation.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of affiliations" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
