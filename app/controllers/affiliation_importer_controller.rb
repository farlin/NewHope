require 'csv'
class AffiliationImporterController < ApplicationController
  
  before_action :authenticate_user!

  def process_import
    
    csv_file =  File.read(params[:import_csv_file].tempfile)
    csv_file = csv_file.gsub(/\r\n?/,"\n")

    table = CSV.parse( csv_file, headers: true,  :row_sep => :auto, :col_sep => ",")

    @content = []
    table.each do |rows|

      params = {}
      rows.each do |cell|
        params[  cell[0].underscore.to_sym ] = cell[1]
      end



      # affiliations handler - if there are no affiliation, we don't add them at all!
      #
      unless params[:affiliations].blank?

        affiliations = params[:affiliations].split(',')
        names = Person.name_sanitizer( params[:name] )

        if names.length > 1 

          last_name = Person.get_last_names( names )

          gender = Person.gender_parser ( params[:gender] )
          puts "matching #{ last_name } to be #{ gender }"

          person = Person.find_or_create_by(first_name: names[0], last_name: last_name) do |p|
            p.species = params[:species]
            p.vehicle = params[:vehicle]
            p.weapon = params[:weapon]
            p.gender = gender
          end

          affiliations.each do |affiliation|
            aff = Affiliation.find_or_create_by( name: affiliation )
            aff.people << person unless aff.people.include?(person)
            aff.save!
          end

          # if location is available, let's add them to the person
          if params[:location].present?
            locations = params[:location].split(',')
            locations.each do |location|
              Location.find_or_create_by( address: location ) do |loc|
                loc.people << person unless loc.people.include?(person)
              end
            end
          end

        end 

      end

    end

    respond_to do |format|
      format.html { redirect_to affiliations_url, notice: 'Database was successfully updated.' }
      format.json { head :no_content }
    end
  end
end
