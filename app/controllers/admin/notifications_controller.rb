class Admin::NotificationsController < Admin::BaseController
  before_action :set_admin_notification, only: %i[show edit update destroy]

  # GET /admin/notifications
  def index
    @admin_notifications = Notification.all
  end

  # GET /admin/notifications/1
  def show
  end

  # GET /admin/notifications/new
  def new
    @admin_notification = Notification.new
  end

  # GET /admin/notifications/1/edit
  def edit
  end

  # POST /admin/notifications
  def create
    @admin_notification = Notification.new(admin_notification_params)

    if @admin_notification.save
      redirect_to @admin_notification, notice: 'Notification was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/notifications/1
  def update
    if @admin_notification.update(admin_notification_params)
      redirect_to @admin_notification, notice: 'Notification was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/notifications/1
  def destroy
    @admin_notification.destroy!
    redirect_to admin_notifications_path, notice: 'Notification was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_notification
    @admin_notification = Notification.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_notification_params
    params.expect(admin_notification: %i[content notifiable_type notifiable_id])
  end
end
