class CommentsController < ApplicationController

  def create
    @rant = Rant.find(params[:rant_id])
    @comment = @rant.comments.new(body: params[:comment][:body], user_id: kenny_loggins.id)
    @comment.save!
    redirect_to :back
  end








end