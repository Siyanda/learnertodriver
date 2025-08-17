class Admin::QuestionsController < Admin::BaseController
  before_action :set_admin_question, only: %i[show edit update destroy]

  # GET /admin/questions
  def index
    @admin_questions = Question.all
  end

  # GET /admin/questions/1
  def show
  end

  # GET /admin/questions/new
  def new
    @admin_question = Question.new
  end

  # GET /admin/questions/1/edit
  def edit
  end

  # POST /admin/questions
  def create
    @admin_question = Question.new(admin_question_params)

    if @admin_question.save
      redirect_to @admin_question, notice: 'Question was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/questions/1
  def update
    if @admin_question.update(admin_question_params)
      redirect_to @admin_question, notice: 'Question was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/questions/1
  def destroy
    @admin_question.destroy!
    redirect_to admin_questions_path, notice: 'Question was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_question
    @admin_question = Question.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_question_params
    params.expect(admin_question: %i[content kind information])
  end
end
