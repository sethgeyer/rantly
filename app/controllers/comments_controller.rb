class CommentsController < ApplicationController


  def create

    @commented_item = if params[:user_id]
                        User.find(params[:user_id])
                      else
                        Rant.find(params[:rant_id])
                      end
    @comment = @commented_item.comments.create!(body: params[:comment][:body], commenter_id: kenny_loggins.id)
    redirect_to :back
  end

end