class UserCommentsController < ApplicationController

  def create
    content = build_content
    comment = kenny_loggins.comments.build(content: content)
    comment.save
    redirect_to :back
  end

  private

  def build_content
    UserComment.new(user_id: params[:user_id], body: params[:user_comment][:body])
  end
end
