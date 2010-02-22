begin
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  require 'rubygems'
  require 'bundler'
  Bundler.setup
end

Bundler.require :default
require 'models'

set :app_file, __FILE__
set :haml, :format => :html5, :escape_html => true

get '/' do
  @posts = Post.all(:order => 'created_at DESC')

  haml :posts
end

get '/tags/:tag' do |tag|
  @posts = Post.all(:tags => tag)

  @title = "Tag: #{tag}"
  haml :posts
end

get '/posts/new' do
  @post = Post.new

  @title = 'New Post'
  haml :new
end

post '/posts' do
  @post = Post.new(params[:post])

  if @post.save
    redirect "/posts/#{@post.id}"
  else
    haml :new
  end
end

get '/posts/:id' do |id|
  @post = Post.find(id)
  @comment = Comment.new

  @title = @post.title
  haml :show
end

post '/posts/:id/comments' do |id|
  @post = Post.find(id)
  @comment = @post.comments.build(params[:comment])

  if @comment.save
    redirect "/posts/#{@post.id}"
  else
    @title = @post.title
    haml :show
  end
end

get '/style.css' do
  content_type :css
  sass :style
end
