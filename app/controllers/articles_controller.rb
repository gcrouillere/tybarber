class ArticlesController < ApplicationController

  def create
    @article = Article.create(article_params)
    redirect_to root_path
  end

  def update
    @article = Article.find(params[:article][:id]).update(article_params)
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:content, :name, :user_id, :id)
  end
end
