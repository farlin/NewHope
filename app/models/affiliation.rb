class Affiliation < ApplicationRecord


# ======[ properties rules ]========




# ======[	relationships rules ]========
	has_and_belongs_to_many :people, -> { distinct }



# ======[	validation rules ]========
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	
	validate :name_is_titlecased
	def name_is_titlecased
		if name.present? && !name.start_with?(/[A-Z]/)
			errors.add(:name, "should be titlecased")
		end
	end


# ======[ Hooks ]========

# ======[ other methods ]========

end
