require_relative 'contact'
require_relative 'rolodex'

require 'sinatra'

@@rolodex = Rolodex.new
@@rolodex.add(Contact.new("Brandon", "Craft", "brancraft@gmail.com", "Note"))
@@rolodex.add(Contact.new("Rob", "Ford", "crack_lover@shaw.ca", "He craaaay....."))
@@rolodex.add(Contact.new("Brandon", "Craft", "dublicate@example.com", "Lorem ipsum dolar simut."))
@@rolodex.add(Contact.new("Tester", "McGee", "tester_mcgee@gmail.com", "Lorem ipsum dolar simut."))
#Route for index.html
get '/' do
	@crm_app_name = "Rolodexer" 
	erb :index
end
#Route for displaying all contacts
get '/contacts' do
	erb :contacts
end
#Route to form for adding a contact
get '/contacts/new' do
	erb :new_contact
end
#Route for displaying a particular contact
get '/contacts/:id' do
	@contact = @@rolodex.find_by_id(params[:id].to_i)
	if @contact
    erb :view_contact
  else
    erb :error
  end
end
#Route to edit a particular contact
get '/contacts/:id/edit' do
	@contact = @@rolodex.find_by_id(params[:id].to_i)
	if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end
#Route for posting/adding a new contact to rolodex
post '/contacts' do
	contact = Contact.new(params[:first_name],params[:last_name],params[:email],params[:note])
	@@rolodex.add(contact)
	redirect to('/contacts')
end
#Route to put new values to a particular contact within the rolodex
put '/contacts/:id' do
	@contact = @@rolodex.find_by_id(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]
		redirect to('/contacts')
	else
		raise Sinatra::NotFound
	end
end
#Route to delete a particular contact

delete '/contacts/:id' do
	puts params
	@contact = @@rolodex.find_by_id(params[:id].to_i)
	if @contact
		@@rolodex.delete(@contact)
		redirect to('/contacts')
	else
		erb :error
	end
end








