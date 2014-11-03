class TeamsController < ApplicationController

  before_action :set_team, only: [:edit, :update, :destroy, :show]

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def show
  end

  def edit
  end

  def create
    @team = Team.new(team_params)

    @team.save
    redirect_to teams_url, notice: 'Team Created'
  end

  def update
    @team.update(team_params)
    redirect_to teams_url, notice: 'Team Saved'
  end

  def destroy
    @team.destroy
    redirect_to teams_url, notice: 'Team Deleted'
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def set_team
    @team = Team.find(params[:id])
  end

end
