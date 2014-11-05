class GamesController < ApplicationController

  before_action :set_game, only: [:edit, :update, :destroy, :show]

  def index
    @games = Game.all

    @games_by_team = @games.group_by{|g|
      g.team.name
    }.map{|r,a|
        [r, a.count]
      }

    @games_by_date = @games.group_by{|g|
      g.date
    }.map{|d,g|
        [d, g.count]
      }

    @game_wins_by_size = @games.all.group_by{|g|
      g.team.name
    }.map{|r,g|
      {
          name: r,
          data: g.group_by{|g|
            g.players.size
          }.map{|size, games|
            [size, games.count]
          }.sort
      }
    }
  end

  def new
    @game = Game.new
    @game.assignments.build
  end

  def show

  end

  def edit
  end

  def create
    @game = Game.new(game_params)

    @game.save
    redirect_to games_url, notice: 'Game Created'
  end

  def update
    @game.update(game_params)
    redirect_to games_url, notice: 'Game Saved'
  end

  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game Deleted'
  end

  private

  def game_params
    params.require(:game).permit(:date,:team_id, assignments_attributes: [:id, :player_id, :role_id])
  end

  def set_game
    @game = Game.find(params[:id])
  end

end
