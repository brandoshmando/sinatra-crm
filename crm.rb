require_relative 'contact'
require_relative 'rolodex'

require 'sinatra'

@@rolodex = Rolodex.new

get '/' do
	@crm_app_name = "Roladexer" 
	erb :index
end

get '/contacts' do
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
	contact = Contact.new(params[:first_name],params[:last_name],params[:email],params[:note])
	@@rolodex.add(contact)
	redirect to('/contacts')
end
