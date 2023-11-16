module AuthenticationConcern 
  
  # make sure it's on new line when extending (subclassing) of ActiveSupport
  # both activesupport and concerns are modules
  extend ActiveSupport::Concern

  # included comes from ActiveSupport::Concern
  included do
    before_action :authenticate
  end

  private

  # run this method before_action
  def authenticate
    # crazy out-of-this-world voodoo black magic from rails that:
    # 1.) prompt user of user name and password
    # 2.) return boolean if the username+password matches
    # 3.) redirects them to a denied page if failed.
    # 4.) redirects them to original page if passed.
    # All that in 3-4 lines of code...
    authenticate_or_request_with_http_basic do |username, password|
      # not too sure why wrapping this in a return will result in a error...
      username == ENV['TEMP_ADMIN_USER_NAME'] && password == ENV['TEMP_ADMIN_PASSWORD']
    end
  end
end