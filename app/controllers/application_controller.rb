class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  config.logger = Logger.new(STDOUT)
end
