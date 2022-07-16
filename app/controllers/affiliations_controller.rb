class AffiliationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_affiliation, only: %i[ show edit update destroy ]

  # GET /affiliations or /affiliations.json
  def index
    @affiliations = Affiliation.all
  end

  # GET /affiliations/1 or /affiliations/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_affiliation
      @affiliation = Affiliation.find(params[:id])
    end

end
