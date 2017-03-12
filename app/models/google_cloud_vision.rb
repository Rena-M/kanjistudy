require 'json'
require 'google/apis/vision_v1'

class GoogleCloudVision
  attr_accessor :endpoint_uri, :file_path

  def initialize(file_path)
    @endpoint_uri = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_PRIVATE_KEY']}"
    @file_path = file_path
  end

  def request
    http_client = HTTPClient.new
    content = Base64.strict_encode64(File.new(file_path, 'rb').read)
    response = http_client.post_content(endpoint_uri, request_json(content), 'Content-Type' => 'application/json')
    result_parse(response)
  end

  private

  def request_json(content)
    {
      requests: [{
        image: {
          content: content
        },
        features: [{
          type: "TEXT_DETECTION",
          maxResults: 1
        }]
      }]
    }.to_json
  end

  def result_parse(response)
    result = JSON.parse(response)['responses'].first
    text = result['textAnnotations'].first
    result = "#{text['description']}"
    return result
  end
end
