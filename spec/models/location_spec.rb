require 'rails_helper'

RSpec.describe Location, type: :model do

  describe "Attr" do
    it { should validate_presence_of(:address) }
    it { should validate_uniqueness_of(:address).ignoring_case_sensitivity }


    it 'validates that location address is titlecased' do
      location = Location.new # add in stuff to make sure it will trip your validation
      location.address = "naboo"
      location.valid?

      expect(location).to be_invalid
      expect(location.errors[:address]).to include('should be titlecased')
    end
  end

  describe "Associations" do
    it { should have_and_belong_to_many(:people) }
  end


end
