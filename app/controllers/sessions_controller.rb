class SessionsController < Devise::SessionsController
  def new
  	return redirect_to new_admin_registration_path if Admin.all.size == 0
    super
  end
end