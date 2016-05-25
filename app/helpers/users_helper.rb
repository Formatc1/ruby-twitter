module UsersHelper
  def current_user
    if controller.action_name == 'show'
      super || User.new
    else
      super
    end
  end
end
