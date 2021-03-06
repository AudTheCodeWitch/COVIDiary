class ApplicationController < ActionController::API

  private
  # find the current active user from Auth0
  def current_user
    @user ||= begin
                token = request.headers["Authorization"].to_s.split(" ").last
                payload, header = *JSONWebToken.verify(token)
                User.from_auth_hash(payload)
              end
  rescue JWT::VerificationError, JWT::DecodeError
    nil
  end
end
