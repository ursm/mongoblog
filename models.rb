MongoMapper.database = 'blog'

class Post
  include MongoMapper::Document

  key :title, String, :required => true
  key :content, String, :required => true
  key :tags, Array
  timestamps!

  many :comments
  validates_associated :comments

  def tags_with_spaces
    tags.join(' ')
  end

  def tags_with_spaces=(tags)
    self.tags = tags.split
  end
end

class Comment
  include MongoMapper::EmbeddedDocument

  key :author, String, :required => true
  key :content, String, :required => true
end
