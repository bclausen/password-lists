#!/bin/env ruby
# encoding: utf-8

require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/../db/pwlist.db")

class Grade
	include DataMapper::Resource
	property :id, Serial
	property :name, String

	has n, :schoolclasses

end
