class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # event /events or /events.json
  def create
    @event = Event.new(event_params)
    @event.creator_id = current_user.id
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_url, notice: "event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params) && current_user.id == @event.creator_id
        format.html { redirect_to events_url, notice: "event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    if @event.creator_id == current_user.id
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: "event was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to root, notice: "You don't have permission to destroy this event"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:date, :title, :description)
    end 
end