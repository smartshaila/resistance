class RolesController < ApplicationController

  before_action :set_role, only: [:edit, :update, :destroy, :show]

  def index
    @roles = Role.all

    @total_wins_by_role = Assignment.all.group_by{|a|
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
  end

  def new
    @role = Role.new
  end

  def show
    @role_wins_by_player = @role.assignments.group_by{|a|
      a.winning?
    }.map{|r,a|
      {
          name: r ? 'Wins' : 'Losses',
          data: a.group_by{|a|
            a.player.name
          }.map{|player,assignments|
            [player, assignments.count]
          }.sort
      }
    }.sort_by{|r| r[:name]}
  end

  def edit
  end

  def create
    @role = Role.new(role_params)

    @role.save
    redirect_to roles_url, notice: 'Role Created'
  end

  def update
    @role.update(role_params)
    redirect_to roles_url, notice: 'Role Saved'
  end

  def destroy
    @role.destroy
    redirect_to roles_url, notice: 'Role Deleted'
  end

  private

  def role_params
    params.require(:role).permit(:name, :team_id)
  end

  def set_role
    @role = Role.find(params[:id])
  end

end
