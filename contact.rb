class Contact
	attr_accessor :first_name, :last_name, :email, :note, :id, :time, :personal, :business
	def initialize(first_name,last_name, email, note, personal=nil, business=nil)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@note = note
		@time = Time.now
		@personal = personal
		@business = business
	end

	def time_format(time)
		return "#{time.month}/#{time.month}/#{time.year}"
	end

	def category_format
		if @personal == "true" && @business == "true"
			return "Personal/Business Aquaintance"
		elsif @personal == "true" && @business != "true"
			return "Personal Aquaintance"
		elsif @personal != "true" && @personal == "true"
			return "Business Aquaintance"
		else
			return "No Category Specified"
		end	
	end
end