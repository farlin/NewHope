require 'rails_helper'

RSpec.describe "people/show", type: :view do
  before(:each) do
    @person = assign(:person, Person.create!(
      first_name: "First Name",
      last_name: "Last Name",
      gender: 2,
      weapon: "Weapon",
      vehicle: "Vehicle"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Weapon/)
    expect(rendered).to match(/Vehicle/)
  end
end
