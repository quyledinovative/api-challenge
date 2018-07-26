class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments
  def index
    post = Post.find(params[:post_id])
    @comments = post.comments
    render json: @comments
  end

  # GET /comments/1
  def show
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
    render json: @comment
  end
  def new
    #1st you retrieve the post thanks to params[:post_id]
    post = Post.find(params[:post_id])
    #2nd you build a new one
    @comment = post.comments.build
    render json: @comment
  end
  def edit
    #1st you retrieve the post thanks to params[:post_id]

    post = Post.find(params[:post_id])
    #2nd you retrieve the comment thanks to params[:id]

    @comment = post.comments.find(params[:id])
    render json: @comment
  end
  # POST /comments
  def create
    #1st you retrieve the post thanks to params[:post_id]

    post = Post.find(params[:post_id])

    #2nd you create the comment with arguments in params[:comment]

    @comment = post.comments.build(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: api_v1_post_comment_path(post, @comment)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    #1st you retrieve the post thanks to params[:post_id]

    post = Post.find(params[:post_id])
    #2nd you retrieve the comment thanks to params[:id]

    @comment = post.comments.find(params[:id])
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    #1st you retrieve the post thanks to params[:post_id]

    post = Post.find(params[:post_id])
    #2nd you retrieve the comment thanks to params[:id]

    @comment = post.comments.find(params[:id])
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:comment_content, :comment_owner, :post_id)
    end
end
