class AdminDashboardsController < ApplicationController


  def show
    @data = {
      "result" => [
        {
          "value" => 57,
          "timeframe" => {
            "start" => "2014-10-16T06:00:00.000Z",
            "end" => "2014-10-17T06:00:00.000Z"
          }
        }
      ]
    }

  end


end