class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    if !params[:commentedid].blank?
      @contribucios = Comments.where(user_id: params[:commentedid]).contribucios
    else
      @comments = Comment.all
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end
  
  def reply_comment
    if !current_user.nil?
      @user = current_user
      @comment = Comment.find(params[:id])
      @reply = @comment.replies.create(content: params[:content], user_id: @user.id, parent_id: @comment.id)
      flash[:notice] = "Added your reply"
      redirect_to :action => "show", :id => params[:id]
    else
      redirect_to '/login'
    end
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def users
    id = params[:id]
    user = User.find(id)
    @comments = user.comments
  end
  
  def commented
    id = params[:id]
    @contribucios = Comments.where(user_id: id).contribucios
  end
  
  def like
    if !current_user.nil?
      @comment = Comment.find(params[:id]) 
      VoteComment.create(user_id: current_user.id, comment_id: params[:id])
      format.html { redirect_back(fallback_location: users_comments_url) }
    end
  end
  
  def unlike
    if !current_user.nil?
      @comment = Comment.find(params[:id]) 
      @vote = VoteComment.where(user_id: current_user.id, comment_id: params[:id])
      @comment.vote_comments.destroy(@vote)
      format.html { redirect_back(fallback_location: users_comments_url) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :parent_id)
    end
end
