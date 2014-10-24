class RantCommentsController < ApplicationController
  def create
    content = build_content
    comment = kenny_loggins.comments.build(content: content)

    comment.save
    redirect_to :back
  end

  private

  def build_content
    RantComment.new(rant_id: params[:rant_id], body: params[:rant_comment][:body])
  end
end