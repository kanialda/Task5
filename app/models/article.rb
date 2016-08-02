class Article < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }
  
  def self.import(file)

    spreadsheet = open_spreadsheet(file)

    page_article = spreadsheet.sheet('Article')
    (2..page_article.last_row).each do |no_row|
      @article =
      article_new = Article.new
      article_new.title = page_article.row(no_row)[0]
      article_new.content = page_article.row(no_row)[1]
      article_new.save(validate:false)
    end

    page_comment = spreadsheet.sheet('Comments')
    (2..page_comment.last_row).each do |no_row|
      @comments = Comment.create(
       article_id: @article.id,
       user_id: page_comment.row(no_row)[0],
     content: page_comment.row(no_row)[1])
    end
  end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when '.csv' then Csv.new(file.path, nil, :ignore)
  when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
  when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end

end
