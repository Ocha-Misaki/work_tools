class Users::ReflectionsController < Users::ApplicationController
  before_action :set_reflection, only: %i[show edit update destroy]

  def index
    @reflections = current_user.reflections.default_order
  end

  def new
    @reflection = current_user.reflections.build
  end

  def create
    @reflection = current_user.reflections.build(reflection_params)
    if @reflection.save
      redirect_to users_reflections_path, notice: '振り返りを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @reflection.update(reflection_params)
      redirect_to users_reflection_path(@reflection), notice: '振り返りを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reflection.destroy!
    redirect_to admins_languages_path, notice: '振り返りを削除しました', status: :see_other
  end

  private

  def set_reflection
    @reflection = current_user.reflections.find(params[:id])
  end

  def reflection_params
    params.require(:reflection).permit(:content)
  end
end
