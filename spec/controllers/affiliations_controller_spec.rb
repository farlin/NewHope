require "rails_helper"

RSpec.describe AffiliationsController, :type => :controller do
  
  before (:each) do
    @user = create(:user)
    sign_in @user
  end

  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET show/:id" do
    it "has a 200 status code" do

      affiliation = create(:affiliation)
      get :show, params: { id: affiliation.id } 

      expect(response.status).to eq(200)
    end
  end
end