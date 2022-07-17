require "rails_helper"

RSpec.describe AffiliationImporterController do


  before (:each) do
    @user = create(:user)
    sign_in @user
  end

  describe "POST unsuccessful #upload" do

    it "complains about file that cannot be opened"
    it "complains about file with permission restriction"

    it "complains about file that is not there" do
      post :upload, params: { :import_csv_file => nil } 
      expect(flash[:alert]).to eq  "File missing"
    end

    it "complains about empty file" do

      @file = fixture_file_upload('sample_empty.csv', 'text/csv')
      post :upload, params: { :import_csv_file => @file } 
      expect(flash[:alert]).to eq  "File has no valid content."
    end

    it "refuses non-csv file" do

      @file = fixture_file_upload('sample.txt', 'text')
      post :upload, params: { :import_csv_file => @file } 
      expect(flash[:alert]).to eq  "File is not a CSV"
    end

    it "complains about improper file" do

      @file = fixture_file_upload('sample_faulty.csv', 'text/csv')
      post :upload, params: { :import_csv_file => @file } 
      expect(flash[:alert]).to eq  "File has no valid content."
    end

  end

  describe "POST successful #upload" do

    it "redirects to index page" do
      @file = fixture_file_upload('sample.csv', 'text/csv')
      post :upload, params: { :import_csv_file => @file } 

      expect(flash[:notice]).to eq "Database was successfully updated."
      expect(response).to redirect_to affiliations_url
    end

    it "redirects to index page" do
      @file = fixture_file_upload('sample.csv', 'text/csv')
      post :upload, params: { :import_csv_file => @file } 

      expect(flash[:notice]).to eq "Database was successfully updated."
      expect(response).to redirect_to affiliations_url
    end

  end

end