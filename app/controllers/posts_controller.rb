class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		if params[:q]
			@posts = Post.search(params[:q].to_s.capitalize).order("created_at DESC").paginate(:page => params[:page], :per_page => 39)
		else
			@posts = Post.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 39)
		end
	end

	def new
		@post = Post.new
	end

	def create
		# render plain: params[:post].inspect
		@post = Post.new(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
		@post.increment!(:view_count)

		@posts = Post.all.order("rand()").paginate(:page => params[:page], :per_page => 8) #change RANDOM to RAND for localhost use
	end

	def edit
		@post = Post.find(params[:id])
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
	    params.require(:post).permit(:title, :youtube_id, :description)
	end

end
