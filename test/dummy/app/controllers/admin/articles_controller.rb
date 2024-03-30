class Admin::ArticlesController < ApplicationController
  include ImplicitResource

  private

  def permitted_params
    params.require(:article).permit(:title, :body)
  end
end
