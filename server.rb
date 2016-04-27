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
	if params['csvupload'] != nil
		#Die im Formular ausgwählte CSV-Datei wird auf den Server geladen
		#in den Ordner uploads
		File.open('uploads/' + params['csvupload'][:filename], "w") do |f|
		f.write(params['csvupload'][:tempfile].read) end
		#return "The file was successfully uploaded!"
	else
		redirect to("/import")
	end
	#Inhalt der CSV-Datei auslesen und in einem Array ablegen
	@csv= CSV.read('uploads/' + params['csvupload'][:filename], col_sep: ';',headers: true, skip_blanks: true)	# CSV-Datei -> Array mit Headern und Semikolon als separierendes Element
	@csv_array= Array.new
	csv_row_names = Array.new
	@csv[0].each do |cell|
		if cell[0] != nil then
			csv_row_names.push(cell[0])
		end
	end
	@csv_array.push(csv_row_names)
	@csv.each do |row|
		csv_row_data = Array.new
		row.each do |cell|
			if cell[1] != nil then
				# Im folgenden werden die Umlaute und ß ersetzt mit
				# Hilfe von regulären Ausdrücken
				if (cell[1] =~ /Ä/) != nil then
					cell[1] = $`+"AE" + $'
				end
				if (cell[1] =~ /ä/) != nil then
					cell[1] = $`+"ae" + $'
				end
				if (cell[1] =~ /Ö/) != nil then
					cell[1] = $`+"OE" + $'
				end
				if (cell[1] =~ /ö/) != nil then
					cell[1] = $`+"oe" + $'
				end
				if (cell[1] =~ /Ü/) != nil then
					cell[1] = $`+"UE" + $'
				end
				if (cell[1] =~ /ü/) != nil then
					cell[1] = $`+"ue" + $'
				end
				if (cell[1] =~ /ß/) != nil then
					cell[1] = $`+"ss" + $'
				end
				csv_row_data.push(cell[1])
			end
		end
		@csv_array.push(csv_row_data)
	end

	erb :import_selection
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