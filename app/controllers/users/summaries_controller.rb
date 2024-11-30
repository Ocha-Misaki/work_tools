class Users::SummariesController < Users::ApplicationController
  def create
    response_log = gitlog.request
    response_calender = calendar.request
    commits = response_log + response_calender
    render plain: openai.get_response_by(commits)
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
