class Rolodex
	attr_accessor :contact
	def initialize
		@contacts = []
		@counter = 1000
	end

	def add(contact)
		contact.id = @counter +=1
		@contact << contact
	end
end