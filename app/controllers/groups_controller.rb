class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy]
  before_action :correct_group_user, only: [:show]
  before_action :authenticate_user!

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.members
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.members << current_user
    @group.memberships.first.admin = true
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    if current_user_admin?
      @group.destroy
      redirect_to groups_path
    else
      redirect_to groups_path
      flash[:alert] = 'No permission to do that'
    end
  end

  private

    def group_params
      params.require(:group).permit(:name)
    end

    def set_group
      @group = Group.find(params[:id])
    end

    def correct_group_user
      @group = current_user.groups.find_by(id: params[:id])
      redirect_to root_url if @group.nil?
    end

    def current_user_admin?(group)
    @membership = group.memberships.find_by(user_id: current_user.id, group_id: group.id)
    @membership.admin == true
    end

    helper_method :current_user_admin?
end
