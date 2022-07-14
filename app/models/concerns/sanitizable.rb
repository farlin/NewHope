module Sanitizable
  extend ActiveSupport::Concern
 

  def name_sanitizer res
  	
  	# deals with hypenated name case

    res.humanize.gsub(/\b('?[a-z])/) { $1.capitalize }.split(' ')
  end

end