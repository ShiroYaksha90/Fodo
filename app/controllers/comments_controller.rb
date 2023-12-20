class CommentsController < ApplicationController
  before_action :require_user
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
        ActionCable.server.broadcast "comments_channel", render(partial: 'comments/comment', object: @comment)
    else
        flash[:danger] = 'Comment was not created'
        redirect_to recipe_path(@recipe), status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
