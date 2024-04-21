class PostsController < ApplicationController
  include ImplicitResource

  private

  def permitted_attributes(_resource)
    params.require(:post).permit(:author_id, :slug)
  end
end
