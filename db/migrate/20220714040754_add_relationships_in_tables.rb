class AddRelationshipsInTables < ActiveRecord::Migration[7.0]
  def change


    create_table :affiliations_people, :id => false do |t|
      t.integer :person_id
      t.integer :affiliation_id
    end

    create_table :locations_people, :id => false do |t|
      t.integer :person_id
      t.integer :location_id
    end

  end
end