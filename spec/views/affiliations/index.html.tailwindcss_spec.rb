require 'rails_helper'

RSpec.describe "affiliations/index", type: :view do
  before(:each) do
    assign(:affiliations, [
      Affiliation.create!(
        name: "NameA"
      ),
      Affiliation.create!(
        name: "NameB"
      )
    ])
  end

  it "renders a list of affiliations" do
    render

    expect(rendered).to match /NameA/
    expect(rendered).to match /NameB/
  end
end
