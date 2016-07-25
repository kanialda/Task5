class ArticlesController < ApplicationController
  def index
  end

  def new
    @article = Article.new
  end

  def edit
  end
end
