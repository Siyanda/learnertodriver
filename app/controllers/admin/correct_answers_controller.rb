class Admin::CorrectAnswersController < Admin::BaseController
  before_action :set_admin_correct_answer, only: %i[show edit update destroy]

  # GET /admin/correct_answers
  def index
    @admin_correct_answers = CorrectAnswer.all
  end

  # GET /admin/correct_answers/1
  def show
  end

  # GET /admin/correct_answers/new
  def new
    @admin_correct_answer = CorrectAnswer.new
  end

  # GET /admin/correct_answers/1/edit
  def edit
  end

  # POST /admin/correct_answers
  def create
    @admin_correct_answer = CorrectAnswer.new(admin_correct_answer_params)

    if @admin_correct_answer.save
      redirect_to @admin_correct_answer, notice: 'Correct answer was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/correct_answers/1
  def update
    if @admin_correct_answer.update(admin_correct_answer_params)
      redirect_to @admin_correct_answer, notice: 'Correct answer was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/correct_answers/1
  def destroy
    @admin_correct_answer.destroy!
    redirect_to admin_correct_answers_path, notice: 'Correct answer was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_correct_answer
    @admin_correct_answer = CorrectAnswer.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_correct_answer_params
    params.expect(admin_correct_answer: %i[question_id answer_id])
  end
end
