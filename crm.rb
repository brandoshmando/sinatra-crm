

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

	def self.search(params)
		Contact.all(:first_name => params) |  Contact.all(:last_name => params) | Contact.all(:email => params) |	Contact.all(:note => params) | Contact.all(:id => params)
	end

	def category_format
		if :personal == "true" && :business == "true"
			return "Personal/Business Aqpaintance"
		elsif  :personal == "true" && :business != "true"
			return "Personal Aquaintance"
		elsif :personal != "true" && :business == "true"
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
#Route to search for a particular contact
get '/contacts/search' do
		erb :search
end
#Route for displaying search results
get '/contacts/search/results' do	
	@results = Contact.search(params[:search])
	if @results.empty?
		redirect to('contacts/search')
	elsif
		@results.size == 1
		redirect to("/contacts/#{@results[0].id}")
	else
		erb :results
	end
end
#Route for displaying a particular contact
get '/contacts/:id' do
	@contact = Contact.get(params[:id].to_i)
	erb :view_contact
end
#Route to edit a particular contact
get '/contacts/:id/edit' do
	@contact = Contact.get(params[:id].to_i)
    erb :edit_contact
  end
#Route for posting/adding a new contact to rolodex
post '/contacts' do
	puts params
	@contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note],
		:personal => params[:personal],
		:business => params[:business]
	)
	redirect to('/contacts')
end
#Route to put new values to a particular contact within the rolodex
put '/contacts/:id' do
	@contact = Contact.get(params[:id].to_i)
		if @contact
			@contact.update(
			:first_name => params[:first_name],
			:last_name => params[:last_name],
			:email => params[:email],
			:note => params[:note])
		else
			erb :error
		end
		redirect to("/contacts/#{@contact.id}")
	end
#Route to delete a particular contact

delete '/contacts/:id' do
	@contact = Contact.get(params[:id].to_i)
	@contact.destroy
	redirect to('/contacts')
end
