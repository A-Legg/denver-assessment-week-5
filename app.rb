require "sinatra"
require "./lib/database"
require "./lib/contact_database"
require "./lib/user_database"

class ContactsApp < Sinatra::Base
  enable :sessions

  def initialize
    super
    @contact_database = ContactDatabase.new
    @user_database = UserDatabase.new

    jeff = @user_database.insert(username: "Jeff", password: "jeff123")
    hunter = @user_database.insert(username: "Hunter", password: "puglyfe")

    @contact_database.insert(:name => "Spencer", :email => "spen@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Jeff D.", :email => "jd@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Mike", :email => "mike@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Kirsten", :email => "kirsten@example.com", user_id: hunter[:id])
  end

  get "/" do
    erb :root
  end

  get "/login" do
    erb :login

  end

  get "/welcome" do
    erb :welcome

  end

  post "/sessions" do
    user = find_user(params)
    session[:user_id] = user[:id] if user
    redirect "/welcome"
  end
  #
  # get "/welcome" do
  #   erb :welcome
  # end

  def find_user(params)
    @user_database.all.select { |user|
      user[:username] == params[:username] && user[:password] == params[:password]
    }.first
  end

  def contacts(contact)
    @contact_database.all.select { |contact|
      contact[:name] }
  end



end
