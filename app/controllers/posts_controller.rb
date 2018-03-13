 class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(page: params[:page] )
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  def like
    @post = Post.find(params[:id])
    a=current_user.id
    respond_to do |format|
      if @post.get_upvotes.where(voter_id:a).size == 0
        @post.get_downvotes.where(voter_id:a).delete_all
        @post.upvote_by current_user
      else
        puts 'You allready liked this post'
      end
      @down_votes = "Dislike " + @post.get_downvotes.size.to_s
      @up_votes = "Like " + @post.get_upvotes.size.to_s
      format.html { redirect_to posts_path }
      format.js
      puts @post.votes_for.size  
    end
  end  

  def dislike
    @post = Post.find(params[:id])
    a=current_user.id
    respond_to do |format|
      if @post.get_downvotes.where(voter_id:a).size == 0
        @post.get_upvotes.where(voter_id:a).delete_all
        @post.downvote_by current_user  
      else
        puts "already disliked"
      end   
      @down_votes = "Dislike " + @post.get_downvotes.size.to_s
      @up_votes = "Like " + @post.get_upvotes.size.to_s
      format.html { redirect_to posts_path }
      format.js
      puts @post.votes_for.size   
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name)
    end
  end
