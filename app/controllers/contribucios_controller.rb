class ContribuciosController < ApplicationController
  before_action :set_contribucio, only: [:show, :edit, :update, :destroy, :like, :news]
  skip_before_action :verify_authenticity_token

  # GET /contribucios or /contribucios.json
  def index
    if !params[:userid].blank?
      @contribucios = Contribucio.where(user_id: params[:userid]).order(like: :desc)
    elsif !params[:likedid].blank?
      if request.headers['X-API-KEY'].present?
        @user = User.where(id: request.headers['X-API-KEY'])
        id = request.headers['X-API-KEY']
      elsif !current_user.blank?
        @user = current_user
        id = current_user.id
      end
      @contribucios = Contribucio.joins("INNER JOIN votes ON votes.contribucio_id = contribucios.id").group!("votes.user_id").having!("votes.user_id=?",id)
    else 
      @contribucios = Contribucio.where(tipus: 'url').order(like: :desc)
    end
  end


  #GET /news or /news.json
  def news
    @contribucios = Contribucio.all.order(created_at: :desc)
    #respond_to do |format|
     # format.json {render json: @contribucios}
    #end
  end

  # GET /contribucios/1 or /contribucios/1.json
  def show
  end

  def asks
    @contribucios = Contribucio.where(tipus: 'ask').order(like: :desc)
    #respond_to do |format|
     # format.json {render json: @contribucios}
    #end
  end

  # GET /contribucios/new
  def new
    @contribucio = Contribucio.new
  end

  # GET /contribucios/1/edit
  def edit
  end
  
  def comentar
    if request.headers['X-API-KEY'].present?
      @user = User.where(id: request.headers['X-API-KEY'])
      id = request.headers['X-API-KEY']
    elsif !current_user.blank?
      @user = current_user
      id = current_user.id
    end
    if !@user.nil?
      @contribucio = Contribucio.find(params[:id])
      @comment = @contribucio.comments.create(content: params[:content], user_id: id, contribucio_id: @contribucio.id)
      flash[:notice] = "Added your comment"
      redirect_to :action => "show", :id => params[:id]
    else
      format.json { render json:{status:"error", code:403, message: "Your api key " + request.headers['X-API-KEY'].to_s + " is not valid"}, status: :forbidden}
      redirect_to '/login'
    end
  end

  # POST /contribucios or /contribucios.json
  def create
    respond_to do |format|
      if request.headers['X-API-KEY'].present?
        @user = User.where(id: request.headers['X-API-KEY'])
        id = request.headers['X-API-KEY']
      elsif !current_user.blank?
        @user = current_user
        id = current_user.id
      end  
      if !@user.nil?
        @contribucio = Contribucio.new(contribucio_params)
        texto = false
        if url_valid?(@contribucio.url) || !@contribucio.texto.blank?
          if (url_valid?(@contribucio.url))
            @contribucio.tipus = 'url'
            texto = !@contribucio.texto.blank?
          else 
            @contribucio.tipus = 'ask'
          end
          @contribucio.user_id = id
          if @contribucio.save
            if texto
              @comment = @contribucio.comments.create(content: @contribucio.texto, user_id: id)
            end
            format.html { redirect_to @contribucio, notice: "Contribucio was successfully created." }
            format.json { render :show, status: :created, location: @contribucio }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @contribucio.errors, status: :unprocessable_entity }
          end
        else
          format.json { render json: {status:"error", code:400, message: "URL not valid"}, status: :bad_request }
          flash[:notice] = "URL IS NOT VALID"
          redirect_to :action => "index"
        end
      else
        format.json { render json:{status:"error", code:403, message: "Your api key " + request.headers['X-API-KEY'].to_s + " is not valid"}, status: :forbidden}
        flash[:notice] = "USER NOT VALID"
        redirect_to :action => "index"
      end
    end
  end
  
  # PATCH/PUT /contribucios/1 or /contribucios/1.json
  def update
    respond_to do |format|
      if @contribucio.update(contribucio_params)
        format.html { redirect_to @contribucio, notice: "Contribucio was successfully updated." }
        format.json { render :show, status: :ok, location: @contribucio }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contribucio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contribucios/1 or /contribucios/1.json
  def destroy
    respond_to do |format|
      if request.headers['X-API-KEY'].present?
        @user = User.where(id: request.headers['X-API-KEY'])
      elsif !current_user.blank?
        @user = current_user
      end  
      if !@user.nil?
        @contribucio.destroy
        format.html { redirect_to contribucios_url, notice: "Contribucio was successfully destroyed." }
        format.json { head :no_content }
      else
        format.json { render json:{status:"error", code:403, message: "Your api key " + request.headers['X-API-KEY'].to_s + " is not valid"}, status: :forbidden}
      end
    end
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
        @contribucio = Contribucio.find(params[:id]) 
        Vote.create(user_id: id, contribucio_id: params[:id])
        @contribucio.like += 1
        @contribucio.save
        format.html { redirect_to contribucios_url, notice: "Contribucio was successfully upvoted." }
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
        @contribucio = Contribucio.find(params[:id]) 
        @vote = Vote.where(user_id: id, contribucio_id: params[:id])
        @contribucio.like = @contribucio.like - 1
        @contribucio.save
        @contribucio.votes.destroy(@vote)
        Vote.where(user_id: id, contribucio_id: params[:id]).destroy_all
        format.html { redirect_to contribucios_url, notice: "Contribucio was successfully downvoted." }
        format.json { head :no_content }
      else
        format.json { render json:{status:"error", code:403, message: "Your api key " + request.headers['X-API-KEY'].to_s + " is not valid"}, status: :forbidden}
      end
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
      params.require(:contribucio).permit(:tittle, :url, :texto)
    end
    
    # a URL may be technically well-formed but may 
    # not actually be valid, so this checks for both.
    def url_valid?(url)
      url = URI.parse(url) rescue false
      url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
    end 
end