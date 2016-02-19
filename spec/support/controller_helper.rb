module ControllerHelper
  def create_session(user)
    controller.send(:sign_in, user)
  end

  def destroy_session
    controller.send(:sign_out)
  end
end