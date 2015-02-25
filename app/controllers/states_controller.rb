class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]


  def index
    respond_to do |format|
      format.html
      format.csv { send_data @states.to_csv }
    end
  end

  def show
    @images = Image.all
    @listings = Listing.where(state_id: @state).includes(:user).order('created_at DESC')
    fresh_when @state
  end

  def new
    @state = State.new
  end

  def edit
  end

  def create
    @state = State.new(state_params)
    respond_to do |format|
      if @state.save
        format.html { redirect_to states_path, notice: 'State was successfully created.' }
        format.json { render :show, status: :created, location: @state }
      else
        format.html { render :new }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @state.update(state_params)
        format.html { redirect_to states_path, notice: 'State was successfully updated.' }
        format.json { render :show, status: :ok, location: @state }
      else
        format.html { render :edit }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @state.destroy
    respond_to do |format|
      format.html { redirect_to states_url, notice: 'State was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_state
      @state = State.friendly.find(params[:id])
    end

    def state_params
      params.require(:state).permit(:name, :slug)
    end
end
