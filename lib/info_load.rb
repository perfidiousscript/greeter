# frozen_string_literal: true

class InfoLoad
  class << self
    attr_accessor :companies, :guests, :template
    def load_json
      companies = find_file('Companies')
      guests = find_file('Guests')

      @companies = []
      @guests = []

      @template = find_file('Template')

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
end
