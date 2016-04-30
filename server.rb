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
require './helpers/generate_password' #Funktion zum generieren von Passwörtern


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
	#params.to_s
	#Ergebnis von params
	#{"generate_password"=>"on", "length"=>"4", "caps"=>"on", "numbers"=>"on", "special_characters"=>"on", "special_characters_string"=>"!$%&?#*", "csvupload"=>{:filename=>"test2.csv", :type=>"text/csv", :name=>"csvupload", :tempfile=>#, :head=>"Content-Disposition: form-data; name=\"csvupload\"; filename=\"test2.csv\"\r\nContent-Type: text/csv\r\n"}}

	if params['generate_password'] == "on" then
		generate_pw = true
		length = params['length'].to_i
		if params['caps'] == "on" then
			caps = true
		else
			caps = false
		end
		if params['numbers'] == "on" then
			numbers = true
		else
			numbers = false
		end
		if params['special_characters'] == "on" then
			special_characters_string = params['special_characters_string']
		else
			special_characters_string = ""
		end
		special_characters_string
	else
		generate_pw = false
	end

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
			if generate_pw && cell[0] == "password" then
				cell[1] = generate_passwd(length, caps, numbers, special_characters_string)
			end
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

post '/import_selection' do
  i = 1 #Wird verwendet, um class1, firstname1 usw. zu bilden
  class_key = "class" + i.to_s
  firstname_key = "firstname" + i.to_s
  lastname_key = "lastname" + i.to_s
  password_key = "password" + i.to_s

  while params[class_key] != nil && params[firstname_key] != nil && params[lastname_key] != nil
  	classname = params[class_key]
  	class_id = Schoolclass.first(:name => params[class_key]).id
  	firstname = params[firstname_key]
  	lastname = params[lastname_key]
  	password = params[password_key]
  	Student.create(:lastname => params[lastname_key], :firstname => params[firstname_key], :password => params[password_key], :schoolclass_id => class_id )
  	i += 1
  	class_key = "class" + i.to_s
	firstname_key = "firstname" + i.to_s
	lastname_key = "lastname" + i.to_s
  end
  i.to_s
  #erb :import_selection
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