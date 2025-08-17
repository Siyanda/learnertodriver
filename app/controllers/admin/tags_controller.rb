class Admin::TagsController < Admin::BaseController
  before_action :set_admin_tag, only: %i[show edit update destroy]

  # GET /admin/tags
  def index
    @admin_tags = Tag.all
  end

  # GET /admin/tags/1
  def show
  end

  # GET /admin/tags/new
  def new
    @admin_tag = Tag.new
  end

  # GET /admin/tags/1/edit
  def edit
  end

  # POST /admin/tags
  def create
    @admin_tag = Tag.new(admin_tag_params)

    if @admin_tag.save
      redirect_to @admin_tag, notice: 'Tag was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/tags/1
  def update
    if @admin_tag.update(admin_tag_params)
      redirect_to @admin_tag, notice: 'Tag was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/tags/1
  def destroy
    @admin_tag.destroy!
    redirect_to admin_tags_path, notice: 'Tag was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_tag
    @admin_tag = Tag.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_tag_params
    params.expect(admin_tag: %i[slug title status])
  end
end
