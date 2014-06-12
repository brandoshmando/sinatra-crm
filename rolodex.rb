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

	def find_by_id(id)
		@contacts.find {|contact| contact.id == id}
	end

	def delete(contact)
		@contacts.delete(contact)
	end

	# def search(search_term)
	# 	results = []
	# 	search = [:first_name, :last_name, :email, :note, :id]
	# 	@contacts.each do |contact|
	# 		search.each do |method|
	# 			results << contact if contact.send(method) == search_term
	# 		end
	# 	end
end