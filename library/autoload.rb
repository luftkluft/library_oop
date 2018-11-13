# frozen_string_literal: true

MAIN_PATH_ROUTE = 'library/'
MAIN_PATH_NAME = 'db'
MAIN_PATH_FORMAT = '.yml'
MAIN_PATH = MAIN_PATH_ROUTE + MAIN_PATH_NAME + MAIN_PATH_FORMAT

HELP_PATH_ROUTE = 'library/'
HELP_PATH_NAME = 'help'
HELP_PATH_FORMAT = '.txt'
HELP_PATH = HELP_PATH_ROUTE + HELP_PATH_NAME + HELP_PATH_FORMAT

require 'yaml'
require 'ffaker'
require 'date'
require_relative 'reader'
require_relative 'author'
require_relative 'book'
require_relative 'order'
require_relative 'ffaker_data'
require_relative 'generator'
require_relative 'library'
