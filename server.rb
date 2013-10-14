require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_record'
require 'pry'
require_relative 'models/show_song'
require_relative 'config/environments'

after do 
  ActiveRecord::Base.clear_active_connections!
end

# Welcome to Broadway.ly!
get "/" do
	erb :index
end

# Index of all shows
# with links to individual shows

get "/shows" do
	@shows = Show.all
	erb :'shows/index'
end

# Form to create new show

get "/shows/new" do
	erb :'shows/new'
end

# Create action - new show - redirects to that
# show

post "/shows" do
	show = Show.new(params[:show])
  	show.save

  	redirect "/shows/#{show.id}"
end

# Individual show page
# Links to list of all songs `/shows/:id/songs`
# and form to create new songs `/shows/:id/songs/new`

get "/shows/:id" do
	@show = Show.find(params[:id])
  	erb :'shows/show'
end

# Form to create new songs

get "/shows/:id/songs/new" do
	@show = Show.find(params[:id])
	erb :'songs/new'
end

# Create action - new songs for a show - redirects
# to that song

post "/shows/:id/songs" do
	show = Show.find(params[:id])
	song = Song.new(params[:song])
	song.save
	show.songs.append(song)

	redirect "/shows/#{show.id}/songs"
end


# Lists all songs from the show

get "/shows/:id/songs" do
	@show = Show.find(params[:id])
	erb :'songs/index'
end

# Shows just one song from the show

get "/shows/:show_id/songs/:song_id" do
	show = Show.find(params[:show_id])
	@song = show.songs.find(params[:song_id])
	# binding.pry
	erb :'songs/show'
end

