class Team < ActiveRecord::Base
  has_many :roles

  default_scope { order('name ASC') }
end
