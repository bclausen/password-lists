#!/bin/env ruby
# encoding: utf-8

require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/../db/pwlist.db")

class Student
	include DataMapper::Resource
	property :id, Serial
	property :lastname, String
	property :firstname, String
	property :password, String
	property :schoolclass_id, Integer
	property :wifi_accepting, Boolean

	belongs_to :schoolclass
end
