
# frozen_string_literal: true

class GreetingsController < ApplicationController
  #include FileLoad
  before_action :load_json

  def new
    @default_template = @template['template']
  end

  def display
    @greeting = Greeting.new(greeting_params)
    unless @greeting.valid?
      flash[:notice] = "Error: #{@greeting.errors.messages}"
      redirect_back fallback_location: new_greeting_path
      return
    end
    @processed_greeting = @greeting.compose_greeting
  end

  private

  def greeting_params
    params.permit(:company, :guest, :template)
  end

  def load_json
    InfoLoad.load_json
    @companies = InfoLoad.companies
    @guests = InfoLoad.guests
    @template = InfoLoad.template
  end
end
