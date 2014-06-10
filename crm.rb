require_relative 'contact'
require_relative 'rolodex'

require 'sinatra'

@@rolodex = Rolodex.new

get '/' do
	@crm_app_name = "Roladexer" 
	erb :index
end

get '/contacts' do
	@contacts = []
	@contacts << Contact.new("Brandon", "Craft", "email", "note")
	@contacts << Contact.new("Ford", "Ford", "email", "note")
	@contacts << Contact.new("Tester", "McGee", "email", "note")
	
	erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end

get 'contacts/:id' do
	erb :view_contact
end

get 'contacts/:id/edit' do
	erb :edit
end

post '/contacts' do
	attributes = params.only(:first_name, :last_name, :email, :notes)
	contact = Contact.new(attributes)
	@@rolodex.add(contact)
end
