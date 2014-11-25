# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  numTlf     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ActiveRecord::Base
  belongs_to :user
  attr_accessible :nombre, :numTlf, :user_id
end
