require 'csv'
class AffiliationImporterController < ApplicationController
  
  before_action :authenticate_user!
  before_action :check_if_file_present
  


  def check_if_file_present

    unless params[:import_csv_file].present?
      redirect_to affiliations_url, flash: { alert: "File missing" } and return
    end

    if params[:import_csv_file].content_type != "text/csv"
      # not really a full proof check
      redirect_to affiliations_url, flash: { alert: "File is not a CSV" } and return
    end

    begin

      csv_file =  File.read(params[:import_csv_file].tempfile)

    rescue Errno::ENOENT => e
      
      deadgum = "File or directory #{params[:import_csv_file]} doesn't exist."
      redirect_to affiliations_url, flash: { alert: deadgum } and return
    
    rescue Errno::EACCES => e
      
      deadgum = "Can't read from #{params[:import_csv_file]}. No permission."
      redirect_to affiliations_url, flash: { alert: deadgum } and return
    end


  end


  def upload


    deadgum = nil

    csv_file =  File.read(params[:import_csv_file].tempfile)
    table = CSV.parse(csv_file.gsub(/\r\n?/,"\n"), headers: true, :row_sep => :auto, :col_sep => ",")

    if table.length < 1 or !table.headers.include? "Affiliations"
      deadgum = "File has no valid content."
    else

      ImporterService.call(table)
    end

    respond_to do |format|
      if deadgum.blank?
        format.html { redirect_to affiliations_url, notice: 'Database was successfully updated.' }
      else
        format.html { redirect_to affiliations_url, alert: deadgum }
      end
    end

  end
end
