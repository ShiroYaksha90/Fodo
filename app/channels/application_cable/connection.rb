module ApplicationCable
  class Connection < ActionCable::Connection::Base
    dentified_by :current_user
    def connect; end

    def disconnect; end

    protected

    def find_current_user
      if (current_user = User.find_by(id: cookies.signed[:user_id]))
        current_user
      else
        reject_unautherized_connection
      end
    end
  end
end
