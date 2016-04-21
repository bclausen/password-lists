require "sinatra"
require 'sinatra/reloader' if development?

require './classes/schoolclasses'
require './classes/students'
require './classes/users'
require './classes/groups'
require './classes/grades'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/pwlist.db")
DataMapper.finalize

# Startseite
get "/" do
	erb:home
end