class Team < ActiveRecord::Base
  has_many :roles, dependent: :destroy

  default_scope { order('name ASC') }
end
