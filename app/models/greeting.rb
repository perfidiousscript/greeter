# frozen_string_literal: true

class Greeting
  include ActiveModel::Model
  include FileLoad
  validates :company, :guest, :template, presence: true
  validate :template, :check_template


  attr_accessor :company, :guest, :template

  DEFAULT_TEMPLATE = 'time name, and welcome to location! room is now ready for you. Enjoy your stay and let us know if you need anything!'

  def initialize(greeting_hash)
    load_json
    @company = @companies[greeting_hash[:company].to_i-1]
    @guest = @guests[greeting_hash[:guest].to_i-1]
    @template = greeting_hash[:template] || DEFAULT_TEMPLATE
  end

  def compose_greeting
    time = get_time(company.timezone)
  end

  # Converts time and local timezone to a greeting. Since Ruby does not have US/Pacific
  # I need to manually coerce the US/Pacific timezone.
  def get_time(pre_format_timezone)
    timezone = (pre_format_timezone == "US/Western") ? "US/Pacific" : pre_format_timezone
    local_hour = Time.current.in_time_zone(timezone).hour
    case local_hour
      when 0..12
        "Good Morning"
      when 13..18
        "Good Afternoon"
      when 19..23
        "Good Evening"
      else
        "Hello"
    end
  end

  # Checks the template for all the template pieces.
  # Returns 'diff array' which is an array of any missing template pieces
  # An empty array signifies a passing custom template
  def check_template
    template_array = %w[time name location room]
    regex_union = Regexp.union(template_array)
    contents_array = template.scan(regex_union)
    diff_array = template_array - contents_array
    errors.add(:template, "must contain #{diff_array}") unless diff_array.empty?
  end
end
