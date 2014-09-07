class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_filter :require_permission, only: [:edit, :update, :destroy]

	def index
		if params[:q]
			@post = Post.all.paginate(:page => params[:page])
			@posts = Post.search(params[:q].to_s.capitalize).paginate(:page => params[:page])

			@popular = @post.popular
			@latest = @post.latest
			
			render 'search_results'
		else
			@posts = Post.all.paginate(:page => params[:page])
		end
		@featured = @posts.featured.to_a
		@small_featured = @featured.shift(6) if @featured
		@popular = @posts.popular
		@latest = @posts.latest
	end

	def new
		@post = Post.new
	end

	def create
		# render plain: params[:post].inspect
		@post = current_user.posts.new(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
		@post.increment!(:view_count)

		@posts = Post.all.paginate(:page => params[:page])
		@random = @posts.random
		@popular = @posts.popular
		@latest = @posts.latest

		# @posts = Post.all.order("rand()").paginate(:page => params[:page]) #change RANDOM to RAND for localhost use
	end

	def edit
		@post = Post.find(params[:id])
	    if @post
	      render
	    else
	      redirect_to edit_post_path, notice: "Story not found."
	    end
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end

	private
	def post_params
	    params.require(:post).permit(:title, :youtube_id, :description, :featured, :user_id)
	end

	def require_permission
	  if current_user != Post.find(params[:id]).user
	    redirect_to root_path, notice: "You don't have the permission to do that."
	  end
	end

end
