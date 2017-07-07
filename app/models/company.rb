class Company
   include ActiveModel::Model

   validates :id, :company, :city, :timezone, presence: true

   attr_accessor :id, :company, :city, :timezone
 end
