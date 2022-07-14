class Affiliation < ApplicationRecord


# ======[ properties rules ]========




# ======[	relationships rules ]========
	has_and_belongs_to_many :people, -> { distinct }



# ======[	validation rules ]========
	validates :name, presence: true
	




# ======[ Hooks ]========
	before_save :sanitize_data
	def sanitize_data
		self.name = self.name.titlecase	if self.name.present?
		# 
		return true
	end


# ======[ other methods ]========

end
