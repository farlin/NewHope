require 'rails_helper'

RSpec.describe "affiliations/show", type: :view do
  before(:each) do
    @affiliation = assign(:affiliation, Affiliation.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
