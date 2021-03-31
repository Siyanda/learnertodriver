class NewComment < Noticed::Base
# NewComment.with(post: @post).deliver_later(current_user)
# NewComment.with(post: @post).deliver(current_user)

  deliver_by :database, format: :to_database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Define helper methods to make rendering easier.

  def to_database
    {
      type: self.class.name,
      params: params,
    }
  end

  param :post

  def message
    t(".message")
  end

  def url
    post_path(params[:post])
  end
end
