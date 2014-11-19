class User < ActiveRecord::Base
  has_many :contacts, :dependent => :destroy
  attr_accessible :ap1, :ap2, :fechaNac, :nombre, :padre_id
end
