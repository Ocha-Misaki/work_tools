class Users::DailyReportsController < Users::ApplicationController
  before_action :set_daily_report, only: %i[show edit update destroy]

  def index
    @daily_reports = current_user.daily_reports.default_order
  end

  def new
    @daily_report = current_user.daily_reports.build
  end

  def create
    @daily_report = current_user.daily_reports.build(daily_report_params)
    if @daily_report.save
      redirect_to users_daily_reports_path, notice: '日報を作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @daily_report.update(daily_report_params)
      redirect_to users_daily_report_path(@daily_report), notice: '日報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @daily_report.destroy!
    redirect_to admins_languages_path, notice: '日報を削除しました', status: :see_other
  end

  private

  def set_daily_report
    @daily_report = current_user.daily_reports.find(params[:id])
  end

  def daily_report_params
    params.require(:daily_report).permit(:content)
  end
end
