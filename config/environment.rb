# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Mime::Type.register "application/vnd.ms-excel", :xls
Mime::Type.register "application/xlsx", :xlsx