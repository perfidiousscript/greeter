
class GreetingsController < ApplicationController
  before_action :load_json

  def new
    @greeting = Greeting.new
  end

  def display
  end

  private

  def load_json
    companies = find_file('Companies')
    guests = find_file('Guests')

    @companies = []
    @guests = []

    companies.each do |company|
      @companies.push(Company.new(company))
    end
    guests.each do |guest|
      @guests.push(Guest.new(guest))
    end
  end

  def find_file(file_name)
    JSON.parse(File.read(File.join(Rails.root, 'docs', "#{file_name}.json")))
  end
end
