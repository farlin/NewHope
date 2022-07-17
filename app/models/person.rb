class Person < ApplicationRecord

# ======[ properties rules ]========
  
  enum gender: [ :male, :female, :unspecified ]

# ======[ relationships rules ]========

  # A Person can belong to many Locations
  has_and_belongs_to_many :locations,  -> { distinct }
 
  # A Person can belong to many Affiliations
  has_and_belongs_to_many :affiliations,   -> { distinct }

# ======[ validation rules ]========

  # Person should have both a first_name and last_name. 
  validates :first_name, presence: true

  # this rule was commented out because C3-PO and R2-D2 was being ignored
  # 
  # validates_format_of :first_name, :with => /^([^\d\W]|[-])*$/, :multiline => true, :message => "should be string"


  validate :first_name_is_titlecased
  def first_name_is_titlecased
    unless first_name.present? && first_name.start_with?(/[A-Z]/)
      errors.add(:first_name, "should be titlecased")
    end
  end

  validate :last_name_is_titlecased
  def last_name_is_titlecased
    if last_name.present? && !last_name.start_with?(/[A-Z]/)
      errors.add(:last_name, "should be titlecased")
    end
  end



# ======[ Hooks ]========



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

  # takes any name piece joins them up
  # (except first part)
  def self.get_last_names names
    names[1, names.length].join(" ")
  end

  # function to sanitize the name string
  # takes a string, splits by space
  #
  def self.name_sanitizer res

    # tried adding exception in the inflection, but didn't work
    res.humanize.gsub(/\b('?[a-z])/) { $1.capitalize }.split(' ')
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(str)
    names = Person.name_sanitizer( str )
    self.first_name = names[0]
    self.last_name = Person.get_last_names( names )
  end
end
