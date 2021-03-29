class ContribucionsController < ApplicationController
  before_action :set_contribucion, only: [:show, :edit, :update, :destroy, :darlike, :ordenar]

  # GET /contribucions
  # GET /contribucions.json
  def index
    @contribucions = Contribucion.all.order(likes: :desc)
  end

  # GET /contribucions/1
  # GET /contribucions/1.json
  def show
  end

  # GET /contribucions/new
  def new
    @contribucion = Contribucion.new
  end

  # GET /contribucions/1/edit
  def edit
  end

  # POST /contribucions
  # POST /contribucions.json
  def create
    @contribucion = Contribucion.new(contribucion_params)

    respond_to do |format|
      if @contribucion.save
        format.html { redirect_to @contribucion, notice: 'Contribucion was successfully created.' }
        format.json { render :show, status: :created, location: @contribucion }
      else
        format.html { render :new }
        format.json { render json: @contribucion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contribucions/1
  # PATCH/PUT /contribucions/1.json
  def update
    respond_to do |format|
      if @contribucion.update(contribucion_params)
        format.html { redirect_to @contribucion, notice: 'Contribucion was successfully updated.' }
        format.json { render :show, status: :ok, location: @contribucion }
      else
        format.html { render :edit }
        format.json { render json: @contribucion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contribucions/1
  # DELETE /contribucions/1.json
  def destroy
    @contribucion.destroy
    respond_to do |format|
      format.html { redirect_to contribucions_url, notice: 'Contribucion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def darlike
    @contribucion.likes = @contribucion.likes + 1
    @contribucion.save
    respond_to do |format|
      format.html { redirect_to contribucions_url, notice: 'Contribucio was successfully liked.' }
      format.json { head :no_content }
    end
  end
  
  def ordenar
    @contribucions = Contribucion.all.order(created_at: :desc)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribucion
      @contribucion = Contribucion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contribucion_params
      params.require(:contribucion).permit(:title, :url, :content)
    end
end
