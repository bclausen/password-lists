#!/bin/env ruby
# encoding: utf-8

require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/../db/pwlist.db")

class Group
	include DataMapper::Resource
	property :id, Serial
	property :name, String
	property :diskription, String

	has n, :users
end
