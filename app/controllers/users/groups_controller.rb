class Users::GroupsController < Users::ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @groups = Group.default_order
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to users_groups_path, notice: 'グループを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to users_group_path(@group), notice: 'グループを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy!
    redirect_to admins_languages_path, notice: 'グループを削除しました', status: :see_other
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
