class Gitlog
  GITHUB_API_URL = 'https://api.github.com'

  def request
    headers = {
      'Authorization' => "token #{ENV.fetch('GITHUB_TOKEN', nil)}",
      # 'Authorization' => "token #{GITHUB_TOKEN}",
      'User-Agent' => 'Rails App',
    }
    since = "#{Date.today}T00:00:00Z"
    url = "#{GITHUB_API_URL}/repos/#{ENV.fetch('GITHUB_REPO', nil)}/commits?since=#{since}"
    # url = "#{GITHUB_API_URL}/repos/#{GITHUB_REPO}/commits?since=#{since}"
    response = HTTParty.get(url, headers: headers)

    if response.code == 200
      messages = response.parsed_response.map { |commit| commit['commit']['message'] }.join("\n")
    else
      Rails.logger.error "GitHub API Error: #{response.code} - #{response.message}"
      []
    end
  end
end
