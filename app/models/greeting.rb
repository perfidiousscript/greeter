# frozen_string_literal: true

class Greeting
  include ActiveModel::Model
  include FileLoad
  validates :company, :guest, :template, presence: true
  validate :template, :check_template

  attr_accessor :company, :guest, :template

  def initialize(greeting_hash)
    load_json
    @company = @companies[greeting_hash[:company].to_i - 1]
    @guest = @guests[greeting_hash[:guest].to_i - 1]
    @template = greeting_hash[:template]
  end

  # Inserts the selected values into the template.
  def compose_greeting
    greeting_value = get_time(company.timezone)
    name_value = @guest.firstName
    location_value = @company.company
    room_value = @guest.reservation['roomNumber']
    composed_template = @template.gsub(/time/, greeting_value)
                                 .gsub(/firstName/, name_value)
                                 .gsub(/location/, location_value)
                                 .gsub(/roomNumber/, room_value.to_s)
                                 .gsub(/lastName/, @guest.lastName)
                                 .gsub(/city/, @company.city)
  end

  # Converts time and local timezone to a greeting. Since Ruby does not have US/Pacific
  # I need to manually coerce the US/Pacific timezone.
  def get_time(pre_format_timezone)
    timezone = pre_format_timezone == 'US/Western' ? 'US/Pacific' : pre_format_timezone
    local_hour = Time.current.in_time_zone(timezone).hour
    case local_hour
    when 0..11
      'Good Morning'
    when 12..18
      'Good Afternoon'
    when 19..23
      'Good Evening'
    else
      'Hello'
    end
  end

  # Checks the template for basic template pieces.
  # Returns 'diff array' which is an array of any missing template pieces
  # An empty array signifies a passing custom template
  def check_template
    template_array = %w[time firstName location roomNumber]
    regex_union = Regexp.union(template_array)
    contents_array = template.scan(regex_union)
    diff_array = template_array - contents_array
    errors.add(:template, "must contain #{diff_array}") unless diff_array.empty?
  end
end
