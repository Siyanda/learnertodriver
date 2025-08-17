class Admin::ActiveStorageBlobsController < Admin::BaseController
  before_action :set_admin_active_storage_blob, only: %i[show edit update destroy]

  # GET /admin/active_storage_blobs
  def index
    @admin_active_storage_blobs = ActiveStorageBlob.all
  end

  # GET /admin/active_storage_blobs/1
  def show
  end

  # GET /admin/active_storage_blobs/new
  def new
    @admin_active_storage_blob = ActiveStorageBlob.new
  end

  # GET /admin/active_storage_blobs/1/edit
  def edit
  end

  # POST /admin/active_storage_blobs
  def create
    @admin_active_storage_blob = ActiveStorageBlob.new(admin_active_storage_blob_params)

    if @admin_active_storage_blob.save
      redirect_to @admin_active_storage_blob, notice: 'Active storage blob was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/active_storage_blobs/1
  def update
    if @admin_active_storage_blob.update(admin_active_storage_blob_params)
      redirect_to @admin_active_storage_blob, notice: 'Active storage blob was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/active_storage_blobs/1
  def destroy
    @admin_active_storage_blob.destroy!
    redirect_to admin_active_storage_blobs_path, notice: 'Active storage blob was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_active_storage_blob
    @admin_active_storage_blob = ActiveStorageBlob.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_active_storage_blob_params
    params.expect(admin_active_storage_blob: %i[key filename content_type metadata service_name byte_size
                                                checksum])
  end
end
