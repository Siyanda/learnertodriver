class Admin::QuizzesController < Admin::BaseController
  before_action :set_admin_quiz, only: %i[show edit update destroy]

  # GET /admin/quizzes
  def index
    @admin_quizzes = Quiz.all
  end

  # GET /admin/quizzes/1
  def show
  end

  # GET /admin/quizzes/new
  def new
    @admin_quiz = Quiz.new
  end

  # GET /admin/quizzes/1/edit
  def edit
  end

  # POST /admin/quizzes
  def create
    @admin_quiz = Quiz.new(admin_quiz_params)

    if @admin_quiz.save
      redirect_to @admin_quiz, notice: 'Quiz was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/quizzes/1
  def update
    if @admin_quiz.update(admin_quiz_params)
      redirect_to @admin_quiz, notice: 'Quiz was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/quizzes/1
  def destroy
    @admin_quiz.destroy!
    redirect_to admin_quizzes_path, notice: 'Quiz was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_quiz
    @admin_quiz = Quiz.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_quiz_params
    params.expect(admin_quiz: %i[title information description duration status slug published_at])
  end
end
