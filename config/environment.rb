# Load the rails application
require File.expand_path('../application', __FILE__)

# this is very useful, specifically for the time_ago_in_words method
include ActionView::Helpers::DateHelper

# showing the output of log entries requires Pretty Print
require 'pp'

# Initialize the rails application
CraigsAdmin::Application.initialize!
