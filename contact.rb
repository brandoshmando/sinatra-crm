class Contact
	attr_accessor :first_name, :last_name, :email, :note, :id
	
	def initialize(attributes = {})
		@first_name = attributes[:first_name]
		@last_name = attributes[:last_name]
		@email = attributes[:email]
		@not = attributes[:note]
	end
end