class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :destroy, :update, :edit]
  before_action :set_applicant, only: [:show, :update]
  around_action :handle_exceptions

  def index
    @challenges = Challenge.all
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(challenge_params)
    if @challenge.save
      redirect_to challenges_path
    else
      render 'new'
    end
  end

  def destroy
    @challenge.destroy
    redirect_to challenges_path
  end

  def show
  end

  def update
    respond_to do |format|
      format.json {render plain: @applicant.log}
      #TestJob.perform_later @applicant.id

=begin      if @challenge.update(challenge_params)
        format.html {redirect_to @challenge, notice: 'Applicant was successfully updated'}
      else
     format.html {render :edit}
      end
=end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def set_applicant
    @applicant = Applicant.where(challenge_id: params[:id]).find_by(token: params[:token])
    if @applicant
      log_in @applicant
    else
      @applicant = Applicant.where(challenge_id: params[:id]).find_by(token: session[:token])
      render json: {error: 'Not Authorized'}, status: 401 unless @applicant
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def challenge_params
    params.require(:challenge).permit(:title, :description)
  end

  def handle_exceptions
    begin
      yield
    rescue NotImplementedError
      puts "Test_error!!"
      sleep 30
      TestJob.perform_later @applicant.id
    end
  end

end