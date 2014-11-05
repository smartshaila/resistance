class PlayersController < ApplicationController

  before_action :set_player, only: [:edit, :update, :destroy, :show]

  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def show
    @results = Team.all.map {|team|
      player_assignments = @player.assignments.select {|a| a if a.team == team}
      results_by_team = player_assignments.map {|pa| pa.team == pa.game.team}
      {:team => team.name, :wins => results_by_team.count(true), :losses => results_by_team.count(false)}
    }

    @player_wins_by_team = @player.assignments.group_by{|a|
      a.winning?
    }.map{|r,a|
      {
        name: r ? 'Wins' : 'Losses',
        data: a.group_by{|a|
          a.team.name
        }.map{|team,assignments|
          [team, assignments.count]
        }.sort
      }
    }.sort_by{|r| r[:name]}

    @player_wins_by_role = @player.assignments.group_by{|a|
      a.winning?
    }.map{|r,a|
      {
          name: r ? 'Wins' : 'Losses',
          data: a.group_by{|a|
            a.role.name
          }.map{|role,assignments|
            [role, assignments.count]
          }.sort
      }
    }.sort_by{|r| r[:name]}

    @player_roles = @player.assignments.group_by{|a|
      a.role.name
    }.map{|r,a|
      [r,a.count]
    }

  end

  def edit
  end

  def create
    @player = Player.new(player_params)

    @player.save
    redirect_to players_url, notice: 'Player Created'
  end

  def update
    @player.update(player_params)
    redirect_to players_url, notice: 'Player Saved'
  end

  def destroy
    @player.destroy
    redirect_to players_url, notice: 'Player Deleted'
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end

  def set_player
    @player = Player.find(params[:id])
  end

end
