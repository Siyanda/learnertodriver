module AuthorizationConcern
  extend ActiveSupport::Concern

  def require_same_user(resource)
    return if current_user == resource.user

    flash[:danger] = t('controllers.notices.no_edit', model: resource.class.name)
    redirect_to root_path
  end
end
