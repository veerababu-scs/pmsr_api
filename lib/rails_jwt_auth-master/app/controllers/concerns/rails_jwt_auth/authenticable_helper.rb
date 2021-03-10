module RailsJwtAuth

  NotAuthorized = Class.new(StandardError)

  module AuthenticableHelper
    
    def current_user
      @current_user
    end

    def jwt_payload
      @jwt_payload
    end

    def signed_in?
      !current_user.nil?
    end

    def get_jwt_from_request
      request.env['HTTP_AUTHORIZATION']&.split&.last
    end

    def authenticate!
      
      begin
        @jwt_payload = RailsJwtAuth::JwtManager.decode(get_jwt_from_request).first
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        unauthorize!
      end
      puts RailsJwtAuth.model.from_token_payload(@jwt_payload)
      if @current_user = RailsJwtAuth.model.from_token_payload(@jwt_payload)
        track_request
      else
        unauthorize!
      end
    end

    def authenticate
      
      begin
        @jwt_payload = RailsJwtAuth::JwtManager.decode(get_jwt_from_request).first
        @current_user = RailsJwtAuth.model.from_token_payload(@jwt_payload)
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        @current_user = nil
      end
      if @current_user==nil
          @check=0
      else
          @check=1
          track_request
      end
    end

    def unauthorize!
      raise NotAuthorized
    end

    def track_request
      if @current_user&.respond_to? :update_tracked_request_info
        @current_user.update_tracked_request_info(request)
      end
    end
  end
end
