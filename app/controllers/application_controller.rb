class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  def after_sign_in_path_for(a)
    user_profile_path
  end
  def after_sign_out_path_for(b)
    request.referrer || root_path
  end

  private
  def admin_only
    unless current_user.admin?
      redirect_to root_path, alert: "Only admin can perform this action"
    end
  end
end
