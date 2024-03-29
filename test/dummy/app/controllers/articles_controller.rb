class ArticlesController < ApplicationController
  include ImplicitResource

  private

  def permitted_attributes(_resource)
    params.require(:article).permit(:title, :body)
  end
end
