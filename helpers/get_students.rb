# Folgende Funktion gibt die Schüler einer Klasse wie folgt aus:
# [[Vorname, Nachname, Passwort, wifi],[Vorname, Nachname, Passwort, wifi],...]

def get_students_by_schoolclassname(sc_name)
	students_array = []
	sc_id = Schoolclass.first(:name => sc_name).id
	class_students = Student.all(:schoolclass_id => sc_id, :order => [:lastname.asc])
	#Achtung: class_students ist nicht sortiert
	class_students.each do |student|
		student_array = []
		student_array.push(student.firstname)
		student_array.push(student.lastname)
		student_array.push(student.password)
		student_array.push(student.wifi_accepting)
		students_array.push(student_array)
	end
	return students_array
end