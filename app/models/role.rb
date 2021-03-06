class Role < ActiveRecord::Base
  belongs_to :team
  has_many :assignments, dependent: :destroy
  has_many :players, through: :assignments
  has_many :games, through: :assignments

  default_scope { order('name ASC') }
end
