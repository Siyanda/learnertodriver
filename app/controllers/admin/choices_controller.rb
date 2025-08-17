class Admin::ChoicesController < Admin::BaseController
  before_action :set_admin_choice, only: %i[show edit update destroy]

  # GET /admin/choices
  def index
    @admin_choices = Choice.all
  end

  # GET /admin/choices/1
  def show
  end

  # GET /admin/choices/new
  def new
    @admin_choice = Choice.new
  end

  # GET /admin/choices/1/edit
  def edit
  end

  # POST /admin/choices
  def create
    @admin_choice = Choice.new(admin_choice_params)

    if @admin_choice.save
      redirect_to @admin_choice, notice: 'Choice was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/choices/1
  def update
    if @admin_choice.update(admin_choice_params)
      redirect_to @admin_choice, notice: 'Choice was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/choices/1
  def destroy
    @admin_choice.destroy!
    redirect_to admin_choices_path, notice: 'Choice was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_choice
    @admin_choice = Choice.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_choice_params
    params.expect(admin_choice: %i[name content value position answer_id question_id evaluation_id])
  end
end
