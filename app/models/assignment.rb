class Assignment < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  belongs_to :role
  has_one :team, through: :role

  def winning?
    self.game.team == self.team
  end
end
