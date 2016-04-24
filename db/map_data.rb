#!/bin/env ruby
# encoding: utf-8


#Bei der Ausführung dieser Datein wird 'pwlist.db' entsprechend der Vorgaben in den Klassen (teachers, usw) erstellt.
require '../classes/schoolclasses'
require '../classes/students'
require '../classes/users'
require '../classes/groups'
require '../classes/grades'
require '../classes/temps'

Schoolclass.auto_migrate!
Student.auto_migrate!
User.auto_migrate!
Group.auto_migrate!
Grade.auto_migrate!
Temp.auto_migrate!