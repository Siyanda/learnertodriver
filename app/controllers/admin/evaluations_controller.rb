class Admin::EvaluationsController < Admin::BaseController
  before_action :set_admin_evaluation, only: %i[show edit update destroy]

  # GET /admin/evaluations
  def index
    @admin_evaluations = Evaluation.all
  end

  # GET /admin/evaluations/1
  def show
  end

  # GET /admin/evaluations/new
  def new
    @admin_evaluation = Evaluation.new
  end

  # GET /admin/evaluations/1/edit
  def edit
  end

  # POST /admin/evaluations
  def create
    @admin_evaluation = Evaluation.new(admin_evaluation_params)

    if @admin_evaluation.save
      redirect_to @admin_evaluation, notice: 'Evaluation was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/evaluations/1
  def update
    if @admin_evaluation.update(admin_evaluation_params)
      redirect_to @admin_evaluation, notice: 'Evaluation was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/evaluations/1
  def destroy
    @admin_evaluation.destroy!
    redirect_to admin_evaluations_path, notice: 'Evaluation was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_evaluation
    @admin_evaluation = Evaluation.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_evaluation_params
    params.expect(admin_evaluation: %i[score status started_at completed_at user_id quiz_id last_choice_id])
  end
end
