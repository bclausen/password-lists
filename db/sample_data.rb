#!/bin/env ruby
# encoding: utf-8
#In dieser Datei werden die Beispieldaten geführt und in die DB eingetragen.

require '../classes/schoolclasses'
require '../classes/students'
require '../classes/users'
require '../classes/groups'
require '../classes/grades'

gradeList = [
	["5"],
	["6"],
	["7"],
	["8"],
	["9"],
	["10"],
	["11"],
	["12"]
]

schoolclassList = [
	["5 a", "6 a", "5"],
	["5 b", "6 b", "5"],
	["5 c", "6 c", "5"],
	["5 d", "6 d", "5"],
	["5 e", "6 e", "5"],
	["6 a", "7 a", "6"],
	["6 b", "7 b", "6"],
	["6 c", "7 c", "6"],
	["6 d", "7 d", "6"],
	["6 e", "7 e", "6"],
	["7 a", "8 a", "7"],
	["7 b", "8 b", "7"],
	["7 c", "8 c", "7"],
	["7 d", "8 d", "7"],
	["7 e", "8 e", "7"],
	["8 a", "9 a", "8"],
	["8 b", "9 b", "8"],
	["8 c", "9 c", "8"],
	["8 d", "9 d", "8"],
	["8 e", "9 e", "8"],
	["9 a", "", "9"],
	["9 b", "", "9"],
	["9 c", "", "9"],
	["9 d", "", "9"],
	["9 e", "", "9"],
	["10 a", "11 a", "10"],
	["10 b", "11 b", "10"],
	["10 b", "11 b", "10"],
	["10 c", "11 c", "10"],
	["10 d", "11 d", "10"],
	["10 e", "11 e", "10"],
	["11 a", "12 a", "11"],
	["11 b", "12 b", "11"],
	["11 c", "12 c", "11"],
	["11 d", "12 d", "11"],
	["11 e", "12 e", "11"],
	["12 a", "", "12"],
	["12 b", "", "12"],
	["12 c", "", "12"],
	["12 d", "", "12"],
	["12 e", "", "12"]
]

#ENDE DER BEISPIELDATEN - BEGINN DER EINSPEICHERUNG

gradeList.each do |grade|
	Grade.create( :name => grade[0])
end

schoolclassList.each do |schoolclass|
	gradeID = Grade.first(name: schoolclass[2]).id
	Schoolclass.create( :name => schoolclass[0], :successor => schoolclass[1], :grade_id => gradeID )
end