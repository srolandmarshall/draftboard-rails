class DraftsController < ApplicationController
  before_action :set_draft, except: %i[index new create]

  # GET /drafts or /drafts.json
  def index
    @drafts = Draft.all
  end

  def start_draft
    @draft.update(active: true)
    redirect_to draft_path(@draft)
  end

  # GET /drafts/1 or /drafts/1.json
  def show
    @available_players = Player.not_drafted(@draft.id)
    @order = @draft.order_with_teams
    @draft_picks = @draft.draft_picks
    @fantasy_teams = @draft.fantasy_teams
  end

  # GET /drafts/new
  def new
    @draft = Draft.new
    @fantasy_leagues = FantasyLeague.all
  end

  # GET /drafts/1/edit
  def edit; end

  # GET /drafts/1/board
  def board
    @order = @draft.order_with_teams
    @draft_picks = @draft.draft_picks
    @fantasy_teams = @draft.fantasy_teams
  end

  # PUT /drafts/1/reset
  def reset
    @draft.reset!
    flash[:warning] = 'Draft has been reset.'
    redirect_to draft_path(@draft)
  end

  # POST /drafts or /drafts.json
  def create
    @draft = Draft.new(draft_params)

    respond_to do |format|
      if @draft.save
        format.html { redirect_to draft_url(@draft), notice: 'Draft was successfully created.' }
        format.json { render :show, status: :created, location: @draft }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drafts/1 or /drafts/1.json
  def update
    respond_to do |format|
      if @draft.update(draft_params)
        format.html { redirect_to draft_url(@draft), notice: 'Draft was successfully updated.' }
        format.json { render :show, status: :ok, location: @draft }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drafts/1 or /drafts/1.json
  def destroy
    @draft.destroy

    respond_to do |format|
      format.html { redirect_to drafts_url, notice: 'Draft was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_draft
    @draft = Draft.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def draft_params
    params.require(:draft).permit(*Draft.column_names(&:to_sym))
  end
end
