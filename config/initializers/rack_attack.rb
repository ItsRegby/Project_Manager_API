class Rack::Attack
  throttle("login/register", limit: 5, period: 1.minute) do |req|
    if req.path.include?("/api/v1/auth/login") || req.path.include?("/api/v1/auth/register")
      req.ip
    end
  end

  self.throttled_responder = ->(env) do
    [ 429, { "Content-Type" => "application/json" }, [ { error: "Too many requests. Please try again later." }.to_json ] ]
  end
end
