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

  validates :nombre, :ap1, :ap2, :fechaNac, :padre_id, presence: true
  validates :nombre, :ap1, :ap2, length: { maximum: 20 }
  validates_uniqueness_of :nombre, scope: [:ap1, :ap2] # xa q no tengan mismo nombre y apellidos !(:nombre + :ap1 + :ap2)

  ################# para validar mediante una función y q t permita hacer cualquier tipo de validación ##################
  #
  # validate :custom_validation
  #
  # def custom_validation
  #   if !nombre.start_with?('J')
  #	 	errors.add(:nombre, 'El nombre no empieza por J')
  #	  end
  # end
  #
  #######################################################################################################################
end