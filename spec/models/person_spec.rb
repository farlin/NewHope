require 'rails_helper'

RSpec.describe Person, type: :model do


  describe "Attr" do

    it { should define_enum_for(:gender) }

    it { should validate_presence_of(:first_name) }

    it 'validates that person name is titlecased' do
      person = Person.new # add in stuff to make sure it will trip your validation
      person.first_name = "chewbaka"
      person.valid?

      expect(person).to be_invalid
      expect(person.errors[:first_name]).to include('should be titlecased')



      person.last_name = "chewbaka"
      person.valid?

      expect(person).to be_invalid
      expect(person.errors[:last_name]).to include('should be titlecased')
    end

    it 'accepts only valid string as name' do
      person = Person.new
      person.name = "-1"
      person.valid?

      expect(person).to be_invalid
      expect(person.errors[:first_name]).to include('should be string')
    end
  end

  describe "gender_parser" do

    random_gender_texts = ["Male", "m", "", "Female", "f", "Other", "o", "-"]

    it  "can classifies different unspecifed gender to other" do
      matches = 0
      random_gender_texts.each do |txt|
        res = Person.gender_parser txt
        if res == :unspecified
          matches += 1
        end
      end

      expect(matches).to eq 4
    end

    it  "can translate different female gender to Female" do
      matches = 0
      random_gender_texts.each do |txt|
        res = Person.gender_parser txt
        if res == :female
          matches += 1
        end
      end

      expect(matches).to eq 2
    end

    it  "can translate different male gender to Male" do
      matches = 0
      random_gender_texts.each do |txt|
        res = Person.gender_parser txt
        if res == :male
          matches += 1
        end
      end

      expect(matches).to eq 2
    end


  end


  describe "name handling methods"  do

  random_names = [
  "Darth Vadar",
"Chewbacca",
"yoda",
"2342432",
"Sheev Palpatine",
"Princess Leia",
"jabba the Hutt",
"Kylo Ren",
"Obi-Wan Kenobi",
"luke skywalker",
"Jar Jar Binks",
"R2-D2",
"Han Solo",
"Boba Fett",
"Rey",
"padme amidala",
"C-3PO",
"Mace Windu",
"-1",
"Lando calrissian"
]

    it 'returns handles exceptional names' do
      person = Person.new
      person.name = "C-3PO"
      expect(person.first_name).to match("C-3PO") 

      person.name = "R2-D2"
      expect(person.first_name).to match("R2-D2") 
    end

    it 'returns formatted first name' do
      person = Person.new
      person.name = "Darth Vadar"
      expect(person.first_name).to match("Darth") 

      person.name = "yoda"
      expect(person.first_name).to match("Yoda")


      person.name = "Obi-Wan Kenobi" 
      expect(person.first_name).to match("Obi-Wan")
    end

    it 'returns formatted last name' do
      person = Person.new
      person.name = "Darth Vadar"
      expect(person.last_name).to match("Vadar") 
    end


    it 'returns name' do
      person = Person.new
      expect(person).to respond_to(:name) 
    end

    it 'returns name with first and last name' do
      person = Person.new
      person.first_name = "fff"
      person.last_name = "lll"

      expect(person.name).to match("fff lll")
    end  
  end

  describe "Associations" do
    it { should have_and_belong_to_many(:affiliations) }
    it { should have_and_belong_to_many(:locations) }
  end
end
