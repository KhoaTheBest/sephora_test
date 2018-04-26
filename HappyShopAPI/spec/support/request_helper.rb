module Requests
  # JsonHelpers
  module JsonHelpers
    def json
      JSON.parse(last_response.body)
    end
  end
end
