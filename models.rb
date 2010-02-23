MongoMapper.database = 'blog'

class Post
  include MongoMapper::Document

  key :title, String, :required => true
  key :content, String, :required => true
  timestamps!

  many :comments
  validates_associated :comments
end

class Comment
  include MongoMapper::EmbeddedDocument

  key :name, String, :required => true
  key :comment, String, :required => true
end
