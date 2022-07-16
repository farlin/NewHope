class Location < ApplicationRecord

# ======[ properties rules ]========




# ======[	relationships rules ]========
	has_and_belongs_to_many :people,  -> { distinct }



# ======[	validation rules ]========
	validates :address, presence: true, uniqueness: { case_sensitive: false }
	


	validate :name_is_titlecased
	def name_is_titlecased
		if address.present? && !address.start_with?(/[A-Z]/)
			errors.add(:address, "should be titlecased")
		end
	end

# ======[ Hooks ]========
	before_save :sanitize_data

	def sanitize_data
		self.address = self.address.titlecase	if self.address.present?
		# 
		return true
	end


# ======[ other methods ]========

end
