class ContribuciosController < ApplicationController
  before_action :set_contribucio, only: [:show, :edit, :update, :destroy, :like, :news]

  # GET /contribucios or /contribucios.json
  def index
    @contribucios = Contribucio.where(tipus: 'url').order(like: :desc)
  end


  #GET /news or /news.json
  def news
    @contribucios = Contribucio.all.order(created_at: :desc)
  end

  # GET /contribucios/1 or /contribucios/1.json
  def show
  end

  def asks
    @contribucios = Contribucio.where(tipus: 'ask').order(like: :desc)
  end

  # GET /contribucios/new
  def new
    @contribucio = Contribucio.new
  end

  # GET /contribucios/1/edit
  def edit
  end
  
  def comentar
    if !current_user.nil?
      @user_id = current_user.id
      @contribucio = Contribucio.find(params[:id])
      @comment = @contribucio.comments.create(content: params[:content], user_id: @user_id)
      flash[:notice] = "Added your comment"
      redirect_to :action => "show", :id => params[:id]
    else
      redirect_to '/login'
    end
  end

  # POST /contribucios or /contribucios.json
  def create
    @contribucio = Contribucio.new(contribucio_params)
    if(url_valid?(@contribucio.url))
      @contribucio.tipus = 'url'
    else
      @contribucio.tipus = 'ask'
    end
    @user = current_user
    @contribucio.user = @user
    respond_to do |format|
      if @contribucio.save
        format.html { redirect_to @contribucio, notice: "Contribucio was successfully created." }
        format.json { render :show, status: :created, location: @contribucio }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contribucio.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def users
    id = params[:id]
    user = User.find(id)
    @contribucios = user.contribucios
  end
  

  # PATCH/PUT /contribucios/1 or /contribucios/1.json
  #def update
  #  respond_to do |format|
  #    if @contribucio.update(contribucio_params)
  #      format.html { redirect_to @contribucio, notice: "Contribucio was successfully updated." }
  #      format.json { render :show, status: :ok, location: @contribucio }
  #    else
  #      format.html { render :edit, status: :unprocessable_entity }
  #      format.json { render json: @contribucio.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /contribucios/1 or /contribucios/1.json
  #def destroy
  #  @contribucio.destroy
  #  respond_to do |format|
  #    format.html { redirect_to contribucios_url, notice: "Contribucio was successfully destroyed." }
  #    format.json { head :no_content }
  #  end
  #end
  
  def like
    if !current_user.nil?
      @contribucio = Contribucio.find(params[:id]) 
      Vote.create(user_id: current_user.id, contribucio_id: params[:id])
      redirect_back(fallback_location: contribucios_url)
    end
  end
  
  def unlike
    if !current_user.nil?
      @contribucio = Contribucio.find(params[:id]) 
      @vote = Vote.where(user_id: current_user.id, contribucio_id: params[:id])
      @contribucio.votes.destroy(@vote)
      redirect_back(fallback_location: contribucios_url)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribucio
      begin 
        @contribucio = Contribucio.find(params[:id])
      rescue
        @contribucio = nil
      end
    end

    # Only allow a list of trusted parameters through.
    def contribucio_params
      params.require(:contribucio).permit(:tittle, :url)
    end
    
    # a URL may be technically well-formed but may 
    # not actually be valid, so this checks for both.
    def url_valid?(url)
      url = URI.parse(url) rescue false
      url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
    end 
end
