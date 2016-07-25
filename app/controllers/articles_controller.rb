class ArticlesController < ApplicationController
  require 'comment'
  before_action :check_current_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @articles = Article.page(params[:page]).per(10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params_article)
    if @article.save
      flash[:notice] = "Success Add Records"
      redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(params_article)
      flash[:notice] = "Success Update Records"
      redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Success Delete a Records"
      redirect_to action: 'index'
    else
      flash[:error] = "fails delete a records"
      redirect_to action: 'index'
    end
  end

  def show
    @article = Article.find_by_id(params[:id])
    @comments = @article.comments.order("id desc")
    @comment = Comment.new
  end

  def edit

  end

  def export_excel
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(:name => "Basic Worksheet") do |sheet|
    (1..10).each { |label| sheet.add_row [label, rand(24)+1] }
      sheet.add_chart(Axlsx::Bar3DChart, :start_at => "A14", :end_at => "F24") do |chart|
        chart.add_series :data => sheet["B1:B10"], :labels => sheet["A1:A10"], :title => sheet["A1"]
      end
    end
    p.serialize('charts.xlsx')

  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def params_article
    params.require(:article).permit(:title, :content)
  end
end
