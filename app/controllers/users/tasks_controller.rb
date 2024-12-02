class Users::TasksController < Users::ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks.default_order
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to users_tasks_path, notice: 'タスクを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to users_task_path(@task), notice: 'タスクを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy!
    redirect_to admins_languages_path, notice: 'タスクを削除しました', status: :see_other
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :parent_task_id)
  end
end
