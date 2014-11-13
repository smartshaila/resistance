class Game < ActiveRecord::Base
  belongs_to :team
  has_many :assignments, dependent: :destroy
  has_many :players, through: :assignments
  has_many :roles, through: :assignments

  accepts_nested_attributes_for :assignments, allow_destroy: true

  default_scope { order('created_at DESC') }
end
