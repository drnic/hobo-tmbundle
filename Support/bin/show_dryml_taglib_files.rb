#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../lib/find_taglibs'
require "pp"
pp Hobo::Dryml.find_taglibs(ENV['TM_FILEPATH'])