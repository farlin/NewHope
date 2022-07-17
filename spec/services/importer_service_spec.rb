require 'rails_helper'
require 'csv'

RSpec.describe ImporterService, type: :model do

  
  before (:each) do
    Person.destroy_all
  end


  describe '#call' do

    # it "processes csv table data" do
    #   res = 'Name,Location,Species,Gender,Affiliations,Weapon,Vehicle\nDarth Vadar,"Death Star, Tatooine",Human,Male,Sith,Lightsaber,Tiefighter\nChewbacca,kashyyk,Wookie,m,Rebel Alliance,Bowcaster,Millennium Falcon'
    #   ttable = CSV.parse(res.gsub(/\r\n?/,"\n"), headers: true, :row_sep => :auto, :col_sep => ",") 
    #   ImporterService.call(ttable)
    # end

    it "skips data without affiliations" do

      before_count = Person.count

      csv_with_chew_only = "Name,Location,Species,Gender,Affiliations,Weapon,Vehicle\nDarth Vadar,\"Death Star, Tatooine\",Human,Male,,Lightsaber,Tiefighter\nChewbacca,kashyyk,Wookie,m,Rebel Alliance,Bowcaster,Millennium Falcon"
      ttable = CSV.parse(csv_with_chew_only.gsub(/\r\n?/,"\n"), headers: true, :row_sep => :auto, :col_sep => ",") 
      ImporterService.call(ttable)

      expect(Person.count).not_to eq(before_count)
      expect(Person.count).to eq(1)

    end

    it "adds data even if location is missing" do

      csv_with_rebel_only = "Name,Location,Species,Gender,Affiliations,Weapon,Vehicle\nDarth Vadar,\"Death Star\",Human,Male,rebel alliance,Lightsaber,Tiefighter\nChewbacca,,Wookie,m,Rebel Alliance,Bowcaster,Millennium Falcon"
      ttable = CSV.parse(csv_with_rebel_only.gsub(/\r\n?/,"\n"), headers: true, :row_sep => :auto, :col_sep => ",") 
      ImporterService.call(ttable)

      expect(Location.count).to eq(1)
      expect(Person.count).to eq(2)

    end


    it "adds data with to same affiliations" do

      before_count = Affiliation.count

      csv_with_rebel_only = "Name,Location,Species,Gender,Affiliations,Weapon,Vehicle\nDarth Vadar,\"Death Star, Tatooine\",Human,Male,Rebel Alliance,Lightsaber,Tiefighter\nChewbacca,kashyyk,Wookie,m,Rebel Alliance,Bowcaster,Millennium Falcon"
      ttable = CSV.parse(csv_with_rebel_only.gsub(/\r\n?/,"\n"), headers: true, :row_sep => :auto, :col_sep => ",") 
      ImporterService.call(ttable)

      expect(Affiliation.count).to eq(1)
      expect(Person.count).to eq(2)

    end

    it "adds data with to same affiliations ignoring case" do

      before_count = Affiliation.count

      csv_with_rebel_only = "Name,Location,Species,Gender,Affiliations,Weapon,Vehicle\nDarth Vadar,\"Death Star, Tatooine\",Human,Male,rebel alliance,Lightsaber,Tiefighter\nChewbacca,kashyyk,Wookie,m,Rebel Alliance,Bowcaster,Millennium Falcon"
      ttable = CSV.parse(csv_with_rebel_only.gsub(/\r\n?/,"\n"), headers: true, :row_sep => :auto, :col_sep => ",") 
      ImporterService.call(ttable)

      expect(Affiliation.count).to eq(1)
      expect(Person.count).to eq(2)

    end

    it "adds data with location" do

      csv_with_two_uniq_locations_only = "Name,Location,Species,Gender,Affiliations,Weapon,Vehicle\nDarth Vadar,\"Death Star, Tatooine\",Human,Male,Rebel Alliance,Lightsaber,Tiefighter\nChewbacca,Tatooine,Wookie,m,Rebel Alliance,Bowcaster,Millennium Falcon"
      ttable = CSV.parse(csv_with_two_uniq_locations_only.gsub(/\r\n?/,"\n"), headers: true, :row_sep => :auto, :col_sep => ",") 
      ImporterService.call(ttable)

      expect(Location.count).to eq(2)
      expect(Person.count).to eq(2)

    end

    it "adds location ignoring case" do

      csv_with_two_uniq_locations_only = "Name,Location,Species,Gender,Affiliations,Weapon,Vehicle\nDarth Vadar,\"Death Star, tatooine\",Human,Male,Rebel Alliance,Lightsaber,Tiefighter\nChewbacca,Tatooine,Wookie,m,Rebel Alliance,Bowcaster,Millennium Falcon"
      ttable = CSV.parse(csv_with_two_uniq_locations_only.gsub(/\r\n?/,"\n"), headers: true, :row_sep => :auto, :col_sep => ",") 
      ImporterService.call(ttable)

      expect(Location.count).to eq(2)
      expect(Person.count).to eq(2)

    end

  end



end