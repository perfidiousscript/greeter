# frozen_string_literal: true

class Greeting
  include ActiveModel::Model
  attr_accessor :company, :guest, :template
  DEFAULT_TEMPLATE = 'time name, and welcome to location! room is now ready for you. Enjoy your stay and let us know if you need anything!'

  def get_time; end

  def compose_greeting; end

  # Checks the template for all the template pieces.
  # Returns 'diff array' which is an array of any missing template pieces
  # An empty array signifies a passing custom template
  def check_template
    template_array = %w[time name location room]
    regex_union = Regexp.union(template_array)
    contents_array = template.scan(regex_union)
    diff_array = template_array - contents_array
  end
end
