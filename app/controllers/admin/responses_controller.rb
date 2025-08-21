class Admin::ResponsesController < Admin::BaseController
  before_action :set_admin_response, only: %i[show edit update destroy]

  # GET /admin/responses
  def index
    @admin_responses = Response.all
  end

  # GET /admin/responses/1
  def show
  end

  # GET /admin/responses/new
  def new
    @admin_response = Response.new
  end

  # GET /admin/responses/1/edit
  def edit
  end

  # POST /admin/responses
  def create
    @admin_response = Response.new(admin_response_params)

    if @admin_response.save
      redirect_to @admin_response, notice: 'Response was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/responses/1
  def update
    if @admin_response.update(admin_response_params)
      redirect_to @admin_response, notice: 'Response was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/responses/1
  def destroy
    @admin_response.destroy!
    redirect_to admin_responses_path, notice: 'Response was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_response
    @admin_response = Response.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_response_params
    params.expect(admin_response: %i[question_id answer_id])
  end
end
