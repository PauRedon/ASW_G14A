class ContribuciosController < ApplicationController
  before_action :set_contribucio, only: [:show, :edit, :update, :destroy, :like, :news]

  # GET /contribucios or /contribucios.json
  def index
    @contribucios = Contribucio.all.order(like: :desc)
  end


  #GET /news or /news.json
  def news
    @contribucios = Contribucio.all.order(created_at: :desc)
  end

  # GET /contribucios/1 or /contribucios/1.json
  def show
  end



  # GET /contribucios/new
  def new
    @contribucio = Contribucio.new
  end

  # GET /contribucios/1/edit
  def edit
  end

  # POST /contribucios or /contribucios.json
  def create
    @contribucio = Contribucio.new(contribucio_params)

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
    @contribucio.destroy
    respond_to do |format|
      format.html { redirect_to contribucios_url, notice: "Contribucio was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def like
      @contribucio.like = @contribucio.like + 1 
      @contribucio.save
      respond_to do |format|
        format.html { redirect_to contribucios_url, notice: 'Contribucio was successfully liked.' }
        format.json { head :no_content }
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribucio
      @contribucio = Contribucio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contribucio_params
      params.require(:contribucio).permit(:tittle, :url, :content)
    end
end
