class PartiesController < ApplicationController
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  def propose
    @party = Party.find(params[:party_id])
    @party.state = 'Proposed'
    @party.save
    redirect_to action: "show", id: params[:party_id]
  end

  def sign
    @party = Party.find(params[:party_id])
    @party.state = 'Signed'
    @party.save
    set_state
    redirect_to action: "show", id: params[:party_id]
  end

  def unsign
    @party = Party.find(params[:party_id])
    @party.state = 'Proposed'
    @party.save
    set_state
    redirect_to action: "show", id: params[:party_id]
  end  

  # GET /parties
  # GET /parties.json
  def index
    if params.has_key?(:code_id)
      logger.info(session[:user_id])
      @parties = Party.where(code_id: params[:code_id])
    else
      @parties = Party.where(user_id: session[:user_id])
    end
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
  end

  # GET /parties/new
  def new
    @party = Party.new
  end

  # GET /parties/1/edit
  def edit
  end

  # POST /parties
  # POST /parties.json
  def create
    @party = Party.new(party_params)

    respond_to do |format|
      if @party.save
        format.html { redirect_to @party, notice: 'Party was successfully created.' }
        format.json { render :show, status: :created, location: @party }
      else
        format.html { render :new }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parties/1
  # PATCH/PUT /parties/1.json
  def update
    respond_to do |format|
      if @party.update(party_params)
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { render :show, status: :ok, location: @party }
      else
        format.html { render :edit }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to parties_url, notice: 'Party was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def party_params
      params.require(:party).permit(:user_id, :code_id, :role_id, :state)
    end

  def set_state
    parties = Party.where(code_id: @party.code.id)
    signed = Array.new
    parties.each{|p| signed << p if p.state == 'Signed'}
    state = 'Not Signed'
    if signed.length == parties.length
      state = 'Signed'
    elsif signed.length > 0
      state = 'Partially Signed'
    end
    @party.code.state = state
    @party.code.save
    if state == 'Signed'
      @party.code.contract.signed_code_id = @party.code.id
        if !@party.code.sc_event_id.nil?
          @party.code.contract.sc_event_id = @party.code.sc_event_id
        end
      @party.code.contract.save
    end
  end
end
