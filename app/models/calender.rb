class Calender
  attr_accessor :start_of_day, :end_of_day

  SCOPES = ['https://www.googleapis.com/auth/calendar.readonly'].freeze
  CREDENTIALS_PATH = 'config/credentials/hackathon20241130-e157686be65f.json'.freeze # 作成した認証情報ファイル

  def initialize
    @calendar_service = Google::Apis::CalendarV3::CalendarService.new
    @calendar_service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(CREDENTIALS_PATH),
      scope: SCOPES
    )
  end

  def start_of_day
    date = Date.today
    date.to_time.iso8601
  end

  def end_of_day
    date = Date.today
    (date + 1).to_time.iso8601
  end

  def request
    response = @calendar_service.list_events(
      'primary', # 取得対象のカレンダーID ('primary' はメインカレンダー)
      time_min: self.start_of_day,
      time_max: self.end_of_day,
      single_events: true, # 繰り返しイベントも展開して取得
      order_by: 'startTime' # 開始時刻順にソート
    )
    response.items.map { |event| event['summary'] }.join("\n")
  end
end
