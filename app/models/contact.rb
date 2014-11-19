class Contact < ActiveRecord::Base
  belongs_to :user
  attr_accessible :nombre, :numTlf
end
