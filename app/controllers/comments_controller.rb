class CommentsController < ApplicationController
  before_action :require_user
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to recipe_path(@recipe.id), flash: { success: 'Comment was created successfully' } }
        format.turbo_stream
      end
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
