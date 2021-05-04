class Posts::TagsController < TagsController
  before_action :set_tagable

  private

    def set_tagable
      @tagable = Post.friendly.find(params[:post_id])
    end
end
