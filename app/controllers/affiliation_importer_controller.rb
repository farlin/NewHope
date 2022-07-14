require 'csv'
class AffiliationImporterController < ApplicationController
  
  before_action :authenticate_user!

  def upload
    
    csv_file =  File.read(params[:import_csv_file].tempfile)
    csv_file = csv_file.gsub(/\r\n?/,"\n")

    table = CSV.parse( csv_file, headers: true,  :row_sep => :auto, :col_sep => ",")

    ImporterService.new(table)

    respond_to do |format|
      format.html { redirect_to affiliations_url, notice: 'Database was successfully updated.' }
      format.json { head :no_content }
    end
  end
end
