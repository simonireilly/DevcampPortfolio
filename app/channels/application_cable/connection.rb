module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    # Custom guest user just for the actioncable connection
    def guest_user
      guest = GuestUser.new
      # object_id is an identifier in memory - quick, easy to access and unique
      guest.id = guest.object_id
      guest.name = 'Guest User'
      guest.first_name = 'Guest'
      guest.last_name = 'User'
      guest.email = 'guest@user.com'

      guest
    end

    def connect
      self.current_user = find_verified_user || guest_user
      # Set up a logger in the console to track the successful implementation
      logger.add_tags 'ActionCable', current_user.email
      logger.add_tags 'ActionCable', current_user.id
    end

    def find_verified_user
      # Bypassing devise to gain access to the warden methods for verified users
      if verified_user = env['warden'].user
        verified_user
      end
    end
  end
end
