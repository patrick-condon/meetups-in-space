require 'sinatra'
require_relative 'config/application'
require 'faker'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.order(:name)
  erb :'meetups/index'
end

get '/meetups/new' do
  @errors = []
  @name = ''
  @location = ''
  @description = ''
  erb :'meetups/new'
end

get '/meetups/:id' do
  @meetup = Meetup.find_by(id: params[:id])
  @errors = []
  erb :'meetups/show'
end

post '/meetups/:id/join' do
  if current_user
    appearance = Appearance.new({
      user_id: @current_user.id,
      meetup_id: params[:id]
    })
    if appearance.valid?
      appearance.save
      flash[:notice] = "Congratulations! You Joined a Meetup in Space"
      redirect "/meetups/#{params[:id]}"
    else
      @meetup = Meetup.find_by(id: params[:id])
      @errors = appearance.errors.full_messages
      erb :'meetups/show'
    end
  else
    @meetup = Meetup.find_by(id: params[:id])
    @errors = ['Please sign in to attend Meetup']
    erb :'meetups/show'
  end
end

post '/meetups/new' do
  if current_user
    meetup = Meetup.new({
      "name" => params[:name],
      "location" => params[:location],
      "creator" => @current_user.username,
      "description" => params[:description]
    })
    if meetup.valid?
      meetup.save
      Appearance.create(user_id: @current_user.id, meetup_id: Meetup.last.id)
      flash[:notice] = "Congratulations! You Created a Meetup in Space"
      redirect "/meetups/#{Meetup.last.id}"
    else
      @name = meetup.name
      @location = meetup.location
      @description = meetup.description
      @errors = meetup.errors.full_messages
      erb :'meetups/new'
    end
  else
    @name = params[:name]
    @location = params[:location]
    @description = params[:description]
    @errors = ['Please sign in to create a Meetup']
    erb :'meetups/new'
   end
end
