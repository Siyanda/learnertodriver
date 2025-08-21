class Admin::QuizQuestionLinkagesController < Admin::BaseController
  before_action :set_admin_quiz_question_linkage, only: %i[show edit update destroy]

  # GET /admin/quiz_question_linkages
  def index
    @admin_quiz_question_linkages = QuizQuestionLinkage.all
  end

  # GET /admin/quiz_question_linkages/1
  def show
  end

  # GET /admin/quiz_question_linkages/new
  def new
    @admin_quiz_question_linkage = QuizQuestionLinkage.new
  end

  # GET /admin/quiz_question_linkages/1/edit
  def edit
  end

  # POST /admin/quiz_question_linkages
  def create
    @admin_quiz_question_linkage = QuizQuestionLinkage.new(admin_quiz_question_linkage_params)

    if @admin_quiz_question_linkage.save
      redirect_to @admin_quiz_question_linkage, notice: 'Quiz question linkage was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/quiz_question_linkages/1
  def update
    if @admin_quiz_question_linkage.update(admin_quiz_question_linkage_params)
      redirect_to @admin_quiz_question_linkage, notice: 'Quiz question linkage was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/quiz_question_linkages/1
  def destroy
    @admin_quiz_question_linkage.destroy!
    redirect_to admin_quiz_question_linkages_path, notice: 'Quiz question linkage was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_quiz_question_linkage
    @admin_quiz_question_linkage = QuizQuestionLinkage.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_quiz_question_linkage_params
    params.expect(admin_quiz_question_linkage: %i[question_id quiz_id])
  end
end
