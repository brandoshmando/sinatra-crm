class Rolodex
	attr_accessor :contacts
	def initialize
		@contacts = []
		@counter = 1000
	end

	def add(contact)
		contact.id = @counter 
		@contacts << contact
		@counter += 1
	end
end