class KeenMetric

  def self.connection
    @conn ||= begin
      conn = Faraday.new(:url => "https://api.keen.io/3.0/projects/#{ENV["KEEN_PROJECT_ID"]}/queries/count?api_key=#{ENV["KEEN_READ_KEY"]}&event_collection=logins&timeframe=today&timezone=-21600&interval=daily") do |faraday|
        faraday.request :url_encoded # form-encode POST params
        faraday.response :logger # log requests to STDOUT
        faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
      end
      conn
    end
  end


  def self.find_logins_per_hour
    response = connection.get
    formatted = JSON.parse(response.body)
    count = formatted["result"][0]
  end


end


