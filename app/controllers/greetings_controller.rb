
class GreetingsController < ApplicationController
  before_action :load_json

  def new
    @greeting = Greeting.new
    @default_template = Greeting::DEFAULT_TEMPLATE.to_s
  end

  def display
    @greeting = Greeting.new(greeting_params)
    template_diff = @greeting.check_template
    unless template_diff.empty?
      flash[:notice] = "Custom template must contain #{template_diff}"
      redirect_back fallback_location: new_greeting_path
      return
    end
    @processed_greeting = @greeting.process
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

  def greeting_params
    params.permit(:company, :guest, :template)
  end
end
