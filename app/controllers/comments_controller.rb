class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  def index
    @comments = Comment.page(params[:page]).per(15)
  end

  def new
    @comment = Comment.new
  end

  def create
    respond_to do |format|
      @comment = Comment.new(params_comment)
      if @comment.save
        format.js {@comments = Article.find_by_id(params[:comment][:article_id]).comments.order("id desc")}
      else
        format.js {@article = Article.find_by_id(params[:comment][:article_id])}
      end
    end
  end

  def edit
  end

  def update
    if @comment.update(params_comment)
      flash[:notice] = "Success Update Records"
      redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'edit'
    end
  end

  def destroy
    if @comment.destroy
      flash[:notice] = "Success Delete a Comments"
      redirect_to action: 'index'
    else
      flash[:error] = "fails delete a comments"
      redirect_to action: 'index'
    end
  end

  def show

  end

  def edit

  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def params_comment
    params.require(:comment).permit(:article_id, :content)
  end
end
