module AuthenticationConcern extend ActiveSupport::concern

  include do
    before_action :authenticate
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == 'Jungle' && password == 'book'
    end
  end
  
end