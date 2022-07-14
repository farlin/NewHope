
class ImporterService

	def initialize(table)
		@table = table
		perform
	end

	def perform 

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

					loc = Location.find_or_create_by( address: location )
					
					unless loc.people.include?(person)
						loc.people << person
						loc.save!
					end
					
				end

			else
				puts "Location unknown for person : #{ params.inspect }"
			end
		end

		def create_affiliations params, person
			
			# we are not going to create anyone without affiliation
			unless params[:affiliations].blank?

				affiliations = params[:affiliations].split(',')
				
				puts "===== #{ person.name } is getting affiliated with #{ affiliations.inspect }"

				affiliations.each do |affiliation|

					aff = Affiliation.find_or_create_by( name: affiliation.titlecase )
					puts "===== #{ affiliation } "

					unless aff.people.include?(person)
						puts "===== #{ person.name } is now affiliated with #{ aff.inspect }"
						aff.people << person 
						aff.save!
					end
				end

			else
				puts "Skip unaffiliated person : #{ params.inspect }"
			end
		end



		def create_person params
			person = nil
			
			# we are not going to create anyone without affiliation
			unless params[:affiliations].blank?

				names = Person.name_sanitizer( params[:name] )

				# a person should have first name and last name (but last name is optional)
				last_name = Person.get_last_names( names )

				person = Person.find_or_create_by(first_name: names[0], last_name: last_name)
				person.species = params[:species]
				person.vehicle = params[:vehicle]
				person.weapon = params[:weapon]
				person.gender = Person.gender_parser ( params[:gender] )
				person.save

			else
				puts "Skip unaffiliated person : #{ params.inspect }"
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
