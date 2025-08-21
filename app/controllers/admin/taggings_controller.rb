class Admin::TaggingsController < Admin::BaseController
  before_action :set_admin_tagging, only: %i[show edit update destroy]

  # GET /admin/taggings
  def index
    @admin_taggings = Tagging.all
  end

  # GET /admin/taggings/1
  def show
  end

  # GET /admin/taggings/new
  def new
    @admin_tagging = Tagging.new
  end

  # GET /admin/taggings/1/edit
  def edit
  end

  # POST /admin/taggings
  def create
    @admin_tagging = Tagging.new(admin_tagging_params)

    if @admin_tagging.save
      redirect_to @admin_tagging, notice: 'Tagging was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/taggings/1
  def update
    if @admin_tagging.update(admin_tagging_params)
      redirect_to @admin_tagging, notice: 'Tagging was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/taggings/1
  def destroy
    @admin_tagging.destroy!
    redirect_to admin_taggings_path, notice: 'Tagging was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_tagging
    @admin_tagging = Tagging.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_tagging_params
    params.expect(admin_tagging: %i[taggable_id taggable_type tag_id])
  end
end
