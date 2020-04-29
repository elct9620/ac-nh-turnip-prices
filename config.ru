#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'

Bundler.require

$LOAD_PATH.unshift(Bundler.root.join('lib'))

require 'turnip_price'

run TurnipPrice.serve
