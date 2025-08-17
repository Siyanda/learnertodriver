class Admin::FriendlyIdSlugsController < Admin::BaseController
  before_action :set_admin_friendly_id_slug, only: %i[show edit update destroy]

  # GET /admin/friendly_id_slugs
  def index
    @admin_friendly_id_slugs = FriendlyIdSlug.all
  end

  # GET /admin/friendly_id_slugs/1
  def show
  end

  # GET /admin/friendly_id_slugs/new
  def new
    @admin_friendly_id_slug = FriendlyIdSlug.new
  end

  # GET /admin/friendly_id_slugs/1/edit
  def edit
  end

  # POST /admin/friendly_id_slugs
  def create
    @admin_friendly_id_slug = FriendlyIdSlug.new(admin_friendly_id_slug_params)

    if @admin_friendly_id_slug.save
      redirect_to @admin_friendly_id_slug, notice: 'Friendly id slug was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/friendly_id_slugs/1
  def update
    if @admin_friendly_id_slug.update(admin_friendly_id_slug_params)
      redirect_to @admin_friendly_id_slug, notice: 'Friendly id slug was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/friendly_id_slugs/1
  def destroy
    @admin_friendly_id_slug.destroy!
    redirect_to admin_friendly_id_slugs_path, notice: 'Friendly id slug was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_friendly_id_slug
    @admin_friendly_id_slug = FriendlyIdSlug.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_friendly_id_slug_params
    params.expect(admin_friendly_id_slug: %i[slug sluggable_id sluggable_type scope])
  end
end
