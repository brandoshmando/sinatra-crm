

require 'sinatra'
require 'pry'
require 'data_mapper'

DataMapper.setup(:default, 'sqlite3:database.sqlite3')
#Creates database within Contact, 
class Contact
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String
	property :created_at, DateTime 
	property :updated_at, DateTime
	property :personal, String
	property :business, String


	def time_format(time)
		return "#{time.month}/#{time.month}/#{time.year}"
	end

	def category_format
		if :personal == "true" && :business == "true"
			return "Personal/Business Aquaintance"
		elsif :personal == "true" && :business != "true"
			return "Personal Aquaintance"
		elsif :personal != "true" && :personal == "true"
			return "Business Aquaintance"
		else
			return "No Category Specified"
		end	
	end
end

DataMapper.finalize
DataMapper.auto_upgrade!

#Route for index.html
get '/' do
	@crm_app_name = "Rolodexer" 
	erb :index
end
#Route for displaying all contacts
get '/contacts' do
	@contacts = Contact.all
	erb :contacts
end
#Route to form for adding a contact
get '/contacts/new' do
	erb :new_contact
end
#Route for displaying a particular contact
get '/contacts/:id' do
	@contact = Contact.fetch(params[:id].to_i)
	erb :view_contact
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
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note],
		:personal => params[:personal],
		:business => params[:business]
	)
	puts contact
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
	@contact = @@rolodex.find_by_id(params[:id].to_i)
	if @contact
		@@rolodex.delete(@contact)
		redirect to('/contacts')
	else
		erb :error
	end
end








