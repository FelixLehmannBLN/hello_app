class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:edit, :update, :destroy]
  before_action :correct_group_user, only: [:show]
  before_action :current_user_admin?, only: [:edit]

  def index
    @user_groups = current_user.groups
    @groups = Group.all
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

  def join
    @group = Group.find(params[:id])
    @member = @group.memberships.build(:user_id => current_user.id)
    if @member.save
      flash[:notice] = "Welcome the #{@group.name}"
      redirect_to groups_path
    else
      redirect_to groups_path
    end
  end

  def leave
    @group = Group.find(params[:id])
    @membership = @group.memberships.find_by(user_id: current_user.id, group_id: group.id)
    if @member.destroy
      flash[:notice] = "You left the group #{@group.name}"
      redirect_to groups_path
    else
      redirect_to groups_path
    end
  end

  def edit
  end

  def update
    if current_user_admin?(@group)
      @group.update_attributes(group_params)
      redirect_to groups_path
      else
        redirect_to groups_path
        flash[:alert] = 'No permission to do that'
      end
    end

  def destroy
    if current_user_admin?(@group)
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
      redirect_to groups_url if @group.nil?
    end

    def current_user_admin?(group = @group)
      @membership = group.memberships.find_by(user_id: current_user.id, group_id: group.id)
      @membership.admin
    end

    helper_method :current_user_admin?
end
