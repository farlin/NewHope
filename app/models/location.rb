class Location < ApplicationRecord

# ======[ properties rules ]========




# ======[	relationships rules ]========
	has_and_belongs_to_many :people, class_name: "Person", :join_table => :locations_people



# ======[	validation rules ]========
	validates :address, presence: true
	




# ======[ Hooks ]========
	before_save :sanitize_data

	def sanitize_data
		self.address = self.address.titlecase	if self.address.present?
		# 
		return true
	end


# ======[ other methods ]========

end
