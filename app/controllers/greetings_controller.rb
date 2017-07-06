
class GreetingsController < ApplicationController
  before_action :load_json


  def new
    byebug
    @greeting = Greeting.new
  end

  def create
  end

  private

  def load_json
    @companies = find_file('Companies')
    @guests = find_file('Guests')
  end

  def find_file(file_name)
    JSON.parse(File.read(File.join(Rails.root, 'docs', "#{file_name}.json")))
  end

end
