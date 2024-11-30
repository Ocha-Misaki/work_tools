class Openai
  def initialize
    access_token = ENV.fetch('OPENAI_ACCESS_TOKEN', nil)
    @client = OpenAI::Client.new(access_token: access_token)
  end

  def get_response_by(commits)
    prompt = <<~TEXT
      以下は今日のコミットログとミーティングの一覧です。この内容を分析し、概要を簡潔にまとめてください：
      #{commits}
    TEXT

    response = @client.chat(
      parameters: {
        model: 'gpt-4o-mini',
        messages: [
          { role: 'system', content: 'You are a helpful assistant.' },
          { role: 'user', content: prompt },
        ],
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end
end
