class FantasyLeaguesController < ApplicationController
  before_action :set_fantasy_league, only: %i[ show edit update destroy ]

  # GET /fantasy_leagues or /fantasy_leagues.json
  def index
    @fantasy_leagues = FantasyLeague.all
  end

  # GET /fantasy_leagues/1 or /fantasy_leagues/1.json
  def show
  end

  # GET /fantasy_leagues/new
  def new
    @fantasy_league = FantasyLeague.new
  end

  # GET /fantasy_leagues/1/edit
  def edit
  end

  # POST /fantasy_leagues or /fantasy_leagues.json
  def create
    @fantasy_league = FantasyLeague.new(fantasy_league_params)

    respond_to do |format|
      if @fantasy_league.save
        format.html { redirect_to fantasy_league_url(@fantasy_league), notice: "Fantasy league was successfully created." }
        format.json { render :show, status: :created, location: @fantasy_league }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fantasy_league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fantasy_leagues/1 or /fantasy_leagues/1.json
  def update
    respond_to do |format|
      if @fantasy_league.update(fantasy_league_params)
        format.html { redirect_to fantasy_league_url(@fantasy_league), notice: "Fantasy league was successfully updated." }
        format.json { render :show, status: :ok, location: @fantasy_league }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fantasy_league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fantasy_leagues/1 or /fantasy_leagues/1.json
  def destroy
    @fantasy_league.destroy

    respond_to do |format|
      format.html { redirect_to fantasy_leagues_url, notice: "Fantasy league was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fantasy_league
      @fantasy_league = FantasyLeague.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fantasy_league_params
      params.fetch(:fantasy_league, {})
    end
end
