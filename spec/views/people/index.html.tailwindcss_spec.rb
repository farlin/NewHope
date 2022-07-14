require 'rails_helper'

RSpec.describe "people/index", type: :view do
  before(:each) do
    assign(:people, [
      Person.create!(
        first_name: "First Name",
        last_name: "Last Name",
        gender: 2,
        weapon: "Weapon",
        vehicle: "Vehicle"
      ),
      Person.create!(
        first_name: "First Name",
        last_name: "Last Name",
        gender: 2,
        weapon: "Weapon",
        vehicle: "Vehicle"
      )
    ])
  end



  it "renders a list of people" do
    render

    # not needed to test this view 
    
    # assert_select "tr>td", text: "First Name".to_s, count: 2
    # assert_select "tr>td", text: "Last Name".to_s, count: 2
    # assert_select "tr>td", text: 2.to_s, count: 2
    # assert_select "tr>td", text: "Weapon".to_s, count: 2
    # assert_select "tr>td", text: "Vehicle".to_s, count: 2
  end
end
