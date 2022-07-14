class Person < ApplicationRecord


# ======[ properties rules ]========
  
  enum gender: [ :male, :female, :unspecified ]
 
  # t.string "first_name", null: false
  # t.string "last_name", null: false
  # t.string "species"
  # t.integer "gender"
  # t.string "weapon"
  # t.string "vehicle"



# ======[ relationships rules ]========

  # A Person can belong to many Locations
  has_and_belongs_to_many :locations,  -> { distinct }
 
  # A Person can belong to many Affiliations
  has_and_belongs_to_many :affiliations,   -> { distinct }

# ======[ validation rules ]========

  # Person should have both a first_name and last_name. 
  validates :first_name, :last_name, presence: true

  # A Person without an Affiliation should be skipped
  # custom validation?

# ======[ Hooks ]========
  # before_save :sanitize_data
  # def sanitize_data
  # removed it in because dealing with hypenated name case
  #   # Names and Locations should all be titlecased
  #   self.first_name = self.first_name.titlecase if self.first_name.present?
  #   self.last_name = self.last_name.titlecase if self.last_name.present?
  #   # 
  #   return true
  # end


# ======[ other methods ]========

  def self.gender_parser str
    str = str.downcase.strip

    if ["m", "male"].include?(str)
      res = :male
    elsif ["f", "female"].include?(str)
      res = :female
    else
      res = :unspecified
    end

    res
  end

  def self.get_last_names names
    names[1, names.length].join(" ")
  end

  def self.name_sanitizer res
    res.humanize.gsub(/\b('?[a-z])/) { $1.capitalize }.split(' ')
  end

  def name
    "#{first_name} #{last_name}"
  end
end
