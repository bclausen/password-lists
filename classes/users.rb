#!/bin/env ruby
# encoding: utf-8

require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/../db/pwlist.db")

class User
	include DataMapper::Resource
	property :id, Serial
	property :lastname, String
	property :firstname, String
	property :username, String
	property :password, String
	property :group_id, Integer

	belongs_to :group
end
