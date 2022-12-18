class DraftsController < ApplicationController
  before_action :set_draft, only: %i[ show edit update destroy ]

  # GET /drafts or /drafts.json
  def index
    @drafts = Draft.all
  end

  # GET /drafts/1 or /drafts/1.json
  def show
  end

  # GET /drafts/new
  def new
    @draft = Draft.new
  end

  # GET /drafts/1/edit
  def edit
  end

  # POST /drafts or /drafts.json
  def create
    @draft = Draft.new(draft_params)

    respond_to do |format|
      if @draft.save
        format.html { redirect_to draft_url(@draft), notice: "Draft was successfully created." }
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
        format.html { redirect_to draft_url(@draft), notice: "Draft was successfully updated." }
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
      format.html { redirect_to drafts_url, notice: "Draft was successfully destroyed." }
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
      params.fetch(:draft, {})
    end
end
