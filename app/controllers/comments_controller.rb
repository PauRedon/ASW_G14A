class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /comments
  # GET /comments.json
  def index
    if !params[:commentedid].blank?
      if request.headers['X-API-KEY'].present?
        @user = User.where(id: request.headers['X-API-KEY'])
        id = request.headers['X-API-KEY']
      elsif !current_user.blank?
        @user = current_user
        id = current_user.id
      end
      @comments = Comment.joins("INNER JOIN vote_comments ON vote_comments.comment_id = comments.id").group!("comments.id, vote_comments.user_id").having!("vote_comments.user_id=?",id)
    elsif !params[:userid].blank?
      if request.headers['X-API-KEY'].present?
        @user = User.where(id: request.headers['X-API-KEY'])
        id = request.headers['X-API-KEY']
      elsif !current_user.blank?
        @user = current_user
        id = current_user.id
      end
      @comments = Comment.where(user_id: id)
    else
      @comments = Comment.all
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end
  
  def reply_comment
    if request.headers['X-API-KEY'].present?
      @user = User.where(id: request.headers['X-API-KEY'])
      id = request.headers['X-API-KEY']
    elsif !current_user.blank?
      @user = current_user
      id = current_user.id
    end
    if !@user.nil?
      @comment = Comment.find(params[:id])
      @reply = @comment.replies.create(content: params[:content], user_id: id, parent_id: @comment.id)
      flash[:notice] = "Added your reply"
      redirect_to :action => "show", :id => params[:id]
    else
      format.json { render json:{status:"error", code:403, message: "Your api key " + request.headers['X-API-KEY'].to_s + " is not valid"}, status: :forbidden}
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
        #format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        #format.json { render :show, status: :created, location: @comment }
        
      #else
        #format.html { render :new }
        #format.json { render json: @comment.errors, status: :unprocessable_entity }
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
    respond_to do |format|
      if request.headers['X-API-KEY'].present?
        @user = User.where(id: request.headers['X-API-KEY'])
        id = request.headers['X-API-KEY']
      elsif !current_user.blank?
        @user = current_user
        id = current_user.id
      end
      if !@user.nil?
        @comment = Comment.find(params[:id]) 
        VoteComment.create(user_id: id, comment_id: params[:id])
        format.html { redirect_to contribucios_url, notice: "Comment was successfully upvoted." }
        format.json { head :no_content }
      else 
        format.json { render json:{status:"error", code:403, message: "Your api key " + request.headers['X-API-KEY'].to_s + " is not valid"}, status: :forbidden}
      end
    end
  end
  
  def unlike
    respond_to do |format|
      if request.headers['X-API-KEY'].present?
        @user = User.where(id: request.headers['X-API-KEY'])
        id = request.headers['X-API-KEY']
      elsif !current_user.blank?
        @user = current_user
        id = current_user.id
      end
      if !@user.nil?
        @comment = Comment.find(params[:id]) 
        @vote = VoteComment.where(user_id: id, comment_id: params[:id])
        @comment.vote_comments.destroy(@vote)
        format.html { redirect_to contribucios_url, notice: "Comment was successfully downvoted." }
        format.json { head :no_content }
      else 
        format.json { render json:{status:"error", code:403, message: "Your api key " + request.headers['X-API-KEY'].to_s + " is not valid"}, status: :forbidden}
      end
      #format.html { redirect_back(fallback_location: users_comments_url) }
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
