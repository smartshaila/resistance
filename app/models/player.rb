class Player < ActiveRecord::Base
	has_many :assignments
	has_many :roles, through: :assignments
	has_many :games, through: :assignments
  has_many :teams, through: :roles

  accepts_nested_attributes_for :assignments, allow_destroy: true

  default_scope { order('name ASC') }
end
