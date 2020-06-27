# frozen_string_literal: true

module Api
  class GoogleOauth2Controller < ApplicationController
    def authenticate
      access_token = exchange_auth_code_for_access_token
      render_unauthorized && return if access_token.nil?

      email = get_users_email(access_token)
      user = User.find_by(email: email)

      user = User.create(email: email) if user.nil?

      render_token(user)
    end

    private

    def render_unauthorized
      render json: { error: 'Authentication failed' }, status: :unauthorized
    end

    def exchange_auth_code_for_access_token
      query = {
        code: params[:auth_code],
        client_id: ENV['GOOGLE_CLIENT_ID'],
        client_secret: ENV['GOOGLE_CLIENT_SECRET'],
        grant_type: 'authorization_code'
      }

      response = HTTParty.post('https://www.googleapis.com/oauth2/v4/token', query: query)
      response['access_token']
    end

    def get_users_email(access_token)
      response = HTTParty.get("https://www.googleapis.com/oauth2/v1/userinfo?access_token=#{access_token}")
      response['email']
    end

    def render_token(user)
      jwt_token = JwtService.encode(payload: {'sub' => user.id})
      render json: {
        success: true,
        auth_token: jwt_token,
        auth_email: user.email
      }, status: :ok
    end
  end
end


private




# query = {
#   code: params[:auth_code],
#   client_id: ENV['GOOGLE_CLIENT_ID'],
#   client_secret: ENV['GOOGLE_CLIENT_SECRET'],
#   redirect_uri: 'http://my-app.com/oauth/callback?provider=google',
#   grant_type: 'authorization_code'
# }

# q={code: code,client_id: GOOGLE_CLIENT_ID, client_secret: GOOGLE_CLIENT_SECRET,  grant_type: 'authorization_code' }
# response = HTTParty.post('https://www.googleapis.com/oauth2/v4/token', query: q)


# r2 = HTTParty.get("https://www.googleapis.com/oauth2/v1/userinfo?access_token=#{response['access_token']}")
# r2['email']  #check if fits that one send to endpoint
