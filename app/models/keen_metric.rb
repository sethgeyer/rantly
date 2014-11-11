class KeenMetric

  def self.connection
    @conn ||= begin
      conn = Faraday.new(:url => "https://api.keen.io") do |faraday|
        faraday.request :url_encoded # form-encode POST params
        faraday.response :logger # log requests to STDOUT
        faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
      end
      conn
    end
  end

  def self.get(url)
    connection.get(url)
  end


  def self.find_logins_per_hour
    response = connection.get("/3.0/projects/#{ENV["KEEN_PROJECT_ID"]}/queries/count?api_key=#{ENV["KEEN_READ_KEY"]}&event_collection=logins&timeframe=this_23_hours&timezone=-21600&group_by=login_date")

    dates = JSON.parse(response.body)["result"]

    logged_hours = dates.map { |record| record["login_date"][11..12] }
    @time = {"1"=> 3, "2"=> 4, "3"=>5, "4"=>0,"5"=>0,"6"=>0,"7"=>0,"8"=>0,"9"=>0,"10"=>0,"11"=>0,"12"=>0,"13"=>0,"14"=>0,"15"=>0,"16"=>0,"17"=>0,"18"=>0,"19"=>0,"20"=>0,"21"=>0,"22"=>0,"23"=>0,"24"=>0}

    logged_hours.each do |hour|
      @time[hour] += 1
    end

    @time

  end


end


