require 'rails_helper'

RSpec.describe Location, type: :model do

  describe "Attr" do
    it { should validate_presence_of(:address) }
    it { should validate_uniqueness_of(:address).ignoring_case_sensitivity }

    it 'validates uniqueness' do
      
      same_name = "Naboo"
      place = Location.new #  creating a loc
      place.address = same_name
      place.save!

      placess = Location.new #  trying to create another one with same name
      placess.address = same_name

      placess.valid?

      expect(placess).to be_invalid
      expect(placess.errors[:address]).to include('has already been taken')
    end


    it 'validates that location address is titlecased' do
      location = Location.new #  creating a loc
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
