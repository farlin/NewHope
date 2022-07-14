require "rails_helper"

RSpec.describe AffiliationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/affiliations").to route_to("affiliations#index")
    end

    it "routes to #show" do
      expect(get: "/affiliations/1").to route_to("affiliations#show", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/affiliations/1").to route_to("affiliations#destroy", id: "1")
    end
  end
end
