class Player < ActiveRecord::Base
	has_many :assignments
	has_many :roles, through: :assignments
	has_many :games, through: :assignments
  has_many :teams, through: :roles

  accepts_nested_attributes_for :assignments, allow_destroy: true

  def win_percent
    self.assignments.map{|a| a.winning?}.count(true).to_f / self.assignments.count.to_f
  end

  default_scope { order('name ASC') }
end
