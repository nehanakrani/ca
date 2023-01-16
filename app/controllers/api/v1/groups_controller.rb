class API::V1::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin, only: %i[assigned_users]
  before_action :set_group, only: %i[show update destroy assigned_users]


  def index
    @groups = Group.all
    render json: @groups
  end

  def show
    render json: @group
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      render json: { data: @group, message: 'Group was created successfully.' }, status: :created
    else
      render json: { error: @group.errors, message: 'Group cannot be created.' }, status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      render json: { message: 'Group was updated successfully.', data: @group }, status: :ok
    else
      render json: { message: @group.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    if @group.destroy!
      render json: { message: 'Group was deleted successfully.' }, status: :ok
    else
      render json: { message: 'Group does not exist!' }, status: :bad_request
    end
  end

  def assigned_users
    unless @group.nil? || params[:user_ids].blank?
      add_users_to_group
      render json: { message: 'Joined group successfully.', data: @group }, status: :ok
    else
      render json: { message: 'Group does not exist!' }, status: :bad_request
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def add_users_to_group
    User.find(params[:user_ids]).each do |user|
      @group.users << user
    end
    @group.save!
  end
end
