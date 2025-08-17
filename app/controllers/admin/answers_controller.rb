class Admin::AnswersController < Admin::BaseController
  before_action :set_admin_answer, only: %i[show edit update destroy]

  # GET /admin/answers
  def index
    @admin_answers = Answer.all
  end

  # GET /admin/answers/1
  def show
  end

  # GET /admin/answers/new
  def new
    @admin_answer = Answer.new
  end

  # GET /admin/answers/1/edit
  def edit
  end

  # POST /admin/answers
  def create
    @admin_answer = Answer.new(admin_answer_params)

    if @admin_answer.save
      redirect_to @admin_answer, notice: 'Answer was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/answers/1
  def update
    if @admin_answer.update(admin_answer_params)
      redirect_to @admin_answer, notice: 'Answer was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/answers/1
  def destroy
    @admin_answer.destroy!
    redirect_to admin_answers_path, notice: 'Answer was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_answer
    @admin_answer = Answer.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_answer_params
    params.expect(admin_answer: %i[name value content information question_id])
  end
end
