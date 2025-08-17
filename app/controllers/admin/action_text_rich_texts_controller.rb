class Admin::ActionTextRichTextsController < Admin::BaseController
  before_action :set_admin_action_text_rich_text, only: %i[show edit update destroy]

  # GET /admin/action_text_rich_texts
  def index
    @admin_action_text_rich_texts = ActionTextRichText.all
  end

  # GET /admin/action_text_rich_texts/1
  def show
  end

  # GET /admin/action_text_rich_texts/new
  def new
    @admin_action_text_rich_text = ActionTextRichText.new
  end

  # GET /admin/action_text_rich_texts/1/edit
  def edit
  end

  # POST /admin/action_text_rich_texts
  def create
    @admin_action_text_rich_text = ActionTextRichText.new(admin_action_text_rich_text_params)

    if @admin_action_text_rich_text.save
      redirect_to @admin_action_text_rich_text, notice: 'Action text rich text was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/action_text_rich_texts/1
  def update
    if @admin_action_text_rich_text.update(admin_action_text_rich_text_params)
      redirect_to @admin_action_text_rich_text, notice: 'Action text rich text was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/action_text_rich_texts/1
  def destroy
    @admin_action_text_rich_text.destroy!
    redirect_to admin_action_text_rich_texts_path, notice: 'Action text rich text was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_action_text_rich_text
    @admin_action_text_rich_text = ActionTextRichText.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_action_text_rich_text_params
    params.expect(admin_action_text_rich_text: %i[name body record_type record_id])
  end
end
