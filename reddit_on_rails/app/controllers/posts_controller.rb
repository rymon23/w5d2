class PostsController < ApplicationController
  
  helper_method :list_all_subs

  def list_all_subs
    Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
    
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url, :subs_id)
  end
end