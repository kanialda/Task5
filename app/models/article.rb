class Article < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }
  
  

def self.import(file)
   
   spreadsheet = open_spreadsheet(file)
   
   page_article = spreadsheet.sheet('Articles')
   (2..page_article.last_row).each do |no_row|
     @article =
       article_new = Article.new
       article_new.title = page_article.row(no_row)[0]
       article_new.content = page_article.row(no_row)[1]
       article_new.published = page_article.row(no_row)[3]
       article_new.save(validate:false)
   end

   page_comment = spreadsheet.sheet('Comments')
   (2..page_comment.last_row).each do |no_row|
     @comments = Comment.create(
       article_id: @article.id,
       user_id: page_comment.row(no_row)[1],
     content: page_comment.row(no_row)[2])
   end

 end

end
