# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  ap1        :string(255)
#  ap2        :string(255)
#  fechaNac   :date
#  padre_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :contacts, :dependent => :destroy
  attr_accessible :ap1, :ap2, :fechaNac, :nombre, :padre_id
end
