require "sinatra"
require 'sinatra/reloader' if development?

require './classes/schoolclasses'
require './classes/students'
require './classes/users'
require './classes/groups'
require './classes/grades'
require 'dm-core'			#Datamapper
require 'dm-migrations'
require 'csv' 	#Verarbeitung von CSV-Dateien

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/pwlist.db")
DataMapper.finalize

# Startseite
get "/" do
	erb:home
end

# Liste der Passwörter
get "/list" do
	erb:list
end

# Import-Seite
get '/import' do
  erb :import
end

post '/import' do
	params['csvupload'].to_s
	# if params['csvupload'] != nil							# Wenn wirklich eine Datei ausgewählt wurde,,
 #  		File.open('public/csv/' + params['csvupload'][:filename], "w") do |f|	# wird diese geöffnet
 #    			f.write(params['csvupload'][:tempfile].read)			# und in den Ordner "/public/csv" geschrieben.
 #  		end
	# 	$filename=params['csvupload'][:filename].to_s				# Globale Variable zum Benutzen in "import"
	# 	$table=params['tab'].to_s						# Globale Variable zum Benutzen in "import"
 #  		redirect to("/import")							# Weiterleitung zum Importskript, welches die gewünschte CSV in die Datenbank einträgt
	# end
	# if params['csvupload'] == nil							# Wenn keine Datein ausgewählt wurde,
	# 	redirect to ("/home")							# wird man auf die Startseite zurückgeleitet.
	# end
  #redirect to ("/import_selection")
end

get '/import_selection' do
  erb :import_selection
end

# Export-Seite
get '/export' do
  erb :export
end

# Daten-Seite
get '/data' do
	@schoolclasses = Schoolclass.all
  erb :data
end

# Druck-Seite
get '/print' do
  erb :print
end