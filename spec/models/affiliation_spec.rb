require 'rails_helper'

RSpec.describe Affiliation, type: :model do


  describe "Attr" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }


    it 'validates that association name is titlecased' do
      affiliation = Affiliation.new # add in stuff to make sure it will trip your validation
      affiliation.name = "naboo"
      affiliation.valid?

      expect(affiliation).to be_invalid
      expect(affiliation.errors[:name]).to include('should be titlecased')
    end
  end

  describe "Associations" do
    it { should have_and_belong_to_many(:people) }
  end

end