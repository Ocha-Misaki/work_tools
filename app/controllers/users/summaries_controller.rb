class Users::SummariesController < Users::ApplicationController
  def create
    delete_session[:summary] # セッションを削除する
    response_log = gitlog.request
    response_calender = calendar.request
    commits = response_log + response_calender
    @summary = openai.get_response_by(commits)
    session[:summary] = @summary　 # セッションに保存する
    redirect_to users_root_path
  end

  private

  def openai
    @openai ||= Openai.new
  end

  def gitlog
    @gitlog = Gitlog.new
  end

  def calendar
    @calendar = Calender.new
  end
end
