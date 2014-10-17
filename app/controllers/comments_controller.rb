class CommentsController < ApplicationController

  def create
    @rant = Rant.find(params[:rant_id])
    @comment = @rant.comments.create!(body: params[:comment][:body], user_id: kenny_loggins.id)
    redirect_to :back
  end

end