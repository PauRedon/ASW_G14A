class VoteCommentsController < ApplicationController
  before_action :set_vote_comment, only: [:show, :edit, :update, :destroy]

  # GET /vote_comments
  # GET /vote_comments.json
  def index
    @vote_comments = VoteComment.all
  end

  # GET /vote_comments/1
  # GET /vote_comments/1.json
  def show
  end

  # GET /vote_comments/new
  def new
    @vote_comment = VoteComment.new
  end

  # GET /vote_comments/1/edit
  def edit
  end

  # POST /vote_comments
  # POST /vote_comments.json
  def create
    @vote_comment = VoteComment.new(vote_comment_params)

    respond_to do |format|
      if @vote_comment.save
        format.html { redirect_to @vote_comment, notice: 'Vote comment was successfully created.' }
        format.json { render :show, status: :created, location: @vote_comment }
      else
        format.html { render :new }
        format.json { render json: @vote_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vote_comments/1
  # PATCH/PUT /vote_comments/1.json
  def update
    respond_to do |format|
      if @vote_comment.update(vote_comment_params)
        format.html { redirect_to @vote_comment, notice: 'Vote comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote_comment }
      else
        format.html { render :edit }
        format.json { render json: @vote_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vote_comments/1
  # DELETE /vote_comments/1.json
  def destroy
    @vote_comment.destroy
    respond_to do |format|
      format.html { redirect_to vote_comments_url, notice: 'Vote comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote_comment
      @vote_comment = VoteComment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_comment_params
      params.fetch(:vote_comment, {})
    end
end
