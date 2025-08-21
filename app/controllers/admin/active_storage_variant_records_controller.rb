class Admin::ActiveStorageVariantRecordsController < Admin::BaseController
  before_action :set_admin_active_storage_variant_record, only: %i[show edit update destroy]

  # GET /admin/active_storage_variant_records
  def index
    @admin_active_storage_variant_records = ActiveStorageVariantRecord.all
  end

  # GET /admin/active_storage_variant_records/1
  def show
  end

  # GET /admin/active_storage_variant_records/new
  def new
    @admin_active_storage_variant_record = ActiveStorageVariantRecord.new
  end

  # GET /admin/active_storage_variant_records/1/edit
  def edit
  end

  # POST /admin/active_storage_variant_records
  def create
    @admin_active_storage_variant_record = ActiveStorageVariantRecord.new(admin_active_storage_variant_record_params)

    if @admin_active_storage_variant_record.save
      redirect_to @admin_active_storage_variant_record, notice: 'Active storage variant record was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/active_storage_variant_records/1
  def update
    if @admin_active_storage_variant_record.update(admin_active_storage_variant_record_params)
      redirect_to @admin_active_storage_variant_record, notice: 'Active storage variant record was successfully updated.',
                                                        status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/active_storage_variant_records/1
  def destroy
    @admin_active_storage_variant_record.destroy!
    redirect_to admin_active_storage_variant_records_path, notice: 'Active storage variant record was successfully destroyed.',
                                                           status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_active_storage_variant_record
    @admin_active_storage_variant_record = ActiveStorageVariantRecord.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_active_storage_variant_record_params
    params.expect(admin_active_storage_variant_record: %i[blob_id variation_digest])
  end
end
