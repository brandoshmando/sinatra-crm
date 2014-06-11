require_relative 'contact'
require_relative 'rolodex'

require 'sinatra'

@@rolodex = Rolodex.new
@@rolodex.add(Contact.new("Brandon", "Craft", "brancraft@gmail.com", "Note"))
@@rolodex.add(Contact.new("Rob", "Ford", "crack_lover@shaw.ca", "He craaaay....."))
@@rolodex.add(Contact.new("Brandon", "Craft", "dublicate@example.com", "Lorem ipsum dolar simut."))
@@rolodex.add(Contact.new("Tester", "McGee", "tester_mcgee@gmail.com", "Lorem ipsum dolar simut."))
get '/' do
	@crm_app_name = "Rolodexer" 
	erb :index
end

get '/contacts' do
	erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end

get '/contacts/:id' do
	@contact = @@rolodex.find_by_id(params[:id].to_i)
	erb :view_contact
end

get 'contacts/:id/edit' do
	erb :edit
end

post '/contacts' do
	contact = Contact.new(params[:first_name],params[:last_name],params[:email],params[:note])
	@@rolodex.add(contact)
	redirect to('/contacts')
end
