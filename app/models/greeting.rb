class Greeting
   include ActiveModel::Model
   attr_accessor :company, :guest
   DEFAULT_GREETING = 'time name, and welcome to location! room is now ready for you. \
  Enjoy your stay and let us know if you need anything!'.freeze

  def get_time
  end

  def compose_greeting
  end

  def check_greeting
  end

end
