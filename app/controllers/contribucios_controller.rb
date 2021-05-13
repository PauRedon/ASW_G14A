class ContribuciosController < ApplicationController
  before_action :set_contribucio, only: [:show, :edit, :update, :destroy, :like, :news]

  # GET /contribucios or /contribucios.json
  def index
    if !params[:userid].blank?
      @contribucios = Contribucio.where(user_id: params[:userid]).order(like: :desc) 
    elsif !params[:likedid].blank?
      @contribucios = Contribucio.joins("INNER JOIN votes ON votes.contribucio_id = contribucios.id").group!("votes.user_id").having!("votes.user_id=?",current_user.id)
    else 
      @contribucios = Contribucio.where(tipus: 'url').order(like: :desc)
    end
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
      @comment = @contribucio.comments.create(content: params[:content], user_id: @user_id, contribucio_id: @contribucio.id)
      flash[:notice] = "Added your comment"
      redirect_to :action => "show", :id => params[:id]
    else
      redirect_to '/login'
    end
  end

  # POST /contribucios or /contribucios.json
  def create
    if request.headers['X-API-KEY'].present?
      @user = User.find(request.headers['X-API-KEY'].to_s)
    elsif !current_user.blank?
      @user = current_user
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
        @contribucio.user = @user
        respond_to do |format|
          if @contribucio.save
            if texto
              @comment = @contribucio.comments.create(content: @contribucio.texto, user_id: @user.id)
            end
            format.html { redirect_to @contribucio, notice: "Contribucio was successfully created." }
            format.json { render :show, status: :created, location: @contribucio }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @contribucio.errors, status: :unprocessable_entity }
          end
        end
      else
        flash[:notice] = "URL IS NOT VALID"
        redirect_to :action => "index"
      end
    else 
      flash[:notice] = "USER NOT LOGGED"
      redirect_to :action => "index"
    end
  end
  
  #def users
  #  id = params[:id]
  #  user = User.find(id)
  #  @contribucios = user.contribucios
  #end
  
  #def liked
  #  id = params[:id]
  #  @votes = Vote.where(user_id: id)
  #  @contribucios = Contribucio.all
  #end
  

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
      @contribucio.like += 1
      @contribucio.save
      #format.html { redirect_back(fallback_location: users_comments_url) }
    end
  end
  
  def unlike
    if !current_user.nil?
      @contribucio = Contribucio.find(params[:id]) 
      @vote = Vote.where(user_id: current_user.id, contribucio_id: params[:id])
      @contribucio.like = @contribucio.like - 1
      @contribucio.save
      @contribucio.votes.destroy(@vote)
      Vote.where(user_id: current_user.id, contribucio_id: params[:id]).destroy_all
      #format.html { redirect_to request.referer }
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
