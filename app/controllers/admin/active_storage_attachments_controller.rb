class Admin::ActiveStorageAttachmentsController < Admin::BaseController
  before_action :set_admin_active_storage_attachment, only: %i[show edit update destroy]

  # GET /admin/active_storage_attachments
  def index
    @admin_active_storage_attachments = ActiveStorageAttachment.all
  end

  # GET /admin/active_storage_attachments/1
  def show
  end

  # GET /admin/active_storage_attachments/new
  def new
    @admin_active_storage_attachment = ActiveStorageAttachment.new
  end

  # GET /admin/active_storage_attachments/1/edit
  def edit
  end

  # POST /admin/active_storage_attachments
  def create
    @admin_active_storage_attachment = ActiveStorageAttachment.new(admin_active_storage_attachment_params)

    if @admin_active_storage_attachment.save
      redirect_to @admin_active_storage_attachment, notice: 'Active storage attachment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/active_storage_attachments/1
  def update
    if @admin_active_storage_attachment.update(admin_active_storage_attachment_params)
      redirect_to @admin_active_storage_attachment, notice: 'Active storage attachment was successfully updated.',
                                                    status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/active_storage_attachments/1
  def destroy
    @admin_active_storage_attachment.destroy!
    redirect_to admin_active_storage_attachments_path, notice: 'Active storage attachment was successfully destroyed.',
                                                       status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_active_storage_attachment
    @admin_active_storage_attachment = ActiveStorageAttachment.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_active_storage_attachment_params
    params.expect(admin_active_storage_attachment: %i[name record_type record_id blob_id])
  end
end
