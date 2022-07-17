
class ImporterService < ApplicationService

	attr_reader :table

	def initialize(table)
		@table = table
	end

	def call 

		@table.each do |rows|

	      params = sanitize_rows(rows)
	      person = create_person (params)

	      if person.present?
	      	
	      	create_affiliations params, person
	      	add_locations params, person

	      end

	    end
	end


	private

		def add_locations params, person

			# if location is available, let's add them to the person
			if params[:location].present?
				locations = params[:location].split(',')
				locations.each do |location|

					location = location.titlecase
					loc = Location.find_or_create_by( address: location )
					
					unless loc.people.include?(person)
						loc.people << person
						loc.save!
					end
					
				end

			else
				Rails.logger.info "Location unknown for person : #{ params.inspect }"
			end
		end

		def create_affiliations params, person
			
			# we are not going to create anyone without affiliation
			unless params[:affiliations].blank?

				affiliations = params[:affiliations].split(',')
				
				Rails.logger.debug "===== #{ person.name } is getting affiliated with #{ affiliations.inspect }"

				affiliations.each do |affiliation|

					aff = Affiliation.find_or_create_by( name: affiliation.titlecase )
					Rails.logger.debug "===== #{ affiliation } "

					unless aff.people.include?(person)
						Rails.logger.debug "===== #{ person.name } is now affiliated with [#{ aff.id } - #{ aff.name }]"
						aff.people << person 
						aff.save!
					end
				end

			else
				Rails.logger.info "Skip unaffiliated person : #{ params.inspect }"
			end
		end



		def create_person params
			person = nil
			
			# we are not going to create anyone without affiliation
			unless params[:affiliations].blank?

				person = Person.new
				person.name =  params[:name]

				if person.valid?
					person.species = params[:species]
					person.vehicle = params[:vehicle]
					person.weapon = params[:weapon]
					person.gender = Person.gender_parser ( params[:gender] )
					person.save
				else

					Rails.logger.error "Things did't work well for #{ params } - errors #{ person.errors.messages }"
					person = nil
				end

			else
				Rails.logger.info "Skip unaffiliated person : #{ params }"
			end

			person
		end


		def sanitize_rows rows
		  params = {}
	      rows.each do |cell|
	      	unless cell[0].blank?
	      		column_name = cell[0].underscore.to_sym
		        params[ column_name ] = cell[1]
		    end
	      end

	      params
		end
end
