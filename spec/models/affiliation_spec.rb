require 'rails_helper'

RSpec.describe Affiliation, type: :model do

  it "has none to begin with" do
    expect(Affiliation.count).to eq 0
  end

  it "has one after adding one" do
    create (:affiliation)
    expect(Affiliation.count).to eq 1
  end

  it "has none after one was created in a previous example" do
    expect(Affiliation.count).to eq 0
  end


  it "not valid without name" do
    res = build(:affiliation, name: " ")
    expect( res.valid? ).to eq false
  end

  it "accepts unique name" do
    create(:affiliation, name: "Gaiya")
    res = build(:affiliation, name: "Gaiya")

    expect( res.valid? ).to eq false
  end

  it "doesn't accept case insensitive name" do
    create(:affiliation, name: "Gaiya")
    res = build(:affiliation, name: "GaiYa")

    expect( res.valid? ).to eq false
  end

end