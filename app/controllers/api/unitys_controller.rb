class Api::UnitysController < ApplicationController
  #before_action :set_applicant, only: [:show, :update]

  require 'net/http'
  require 'uri'

  def index
    datas = Applicant.all
    render json: datas
  end

  def show
    uri = URI.parse('http://192.168.1.105:1337/upload')

    response = Net::HTTP.post_form(uri, {'id' => 1, 'play' => 1, 'source' => '1q2w3e4r!'})

    puts response.body
    render json: {error: 'Not Authorized'}, status: 401 unless @applicant
  end

  def score
    #params.require(:applicant).permit(:name, :total_score, :email, :score_01, :score_02, :score_03, :score_04, :token, :challenge_id, :attachment, :id)

    @applicant = Applicant.where(challenge_id: params[:id]).find_by(id: params[:user_id])
    puts @applicant
=begin
    @t = params[:test_num]
    case @t
      when 1
        @applicant.score_01 = params[:score]
      when 2
        @applicant.score_02 = params[:score]
      when 3
        @applicant.score_03 = params[:score]
      when 4
        @applicant.score_04 = params[:score]
    end

    @applicant.save
=end
    render json: {error: 'Not Authorized'}, status: 401 unless @applicant
  end

=begin
  private
  def set_applicant
    @applicant = Applicant.where(challenge_id: params[:id]).find_by(token: params[:token])
    if @applicant
      log_in @applicant
    else
      @applicant = Applicant.where(challenge_id: params[:id]).find_by(token: session[:token])

      uri = URI.parse('http://192.168.1.105:1337/upload')
      response = Net::HTTP.post_form(uri, {'id' => 1, 'play' => 1, 'source' => '1q2w3e4r!'})

      render json: {error: 'Not Authorized'}, status: 401 unless @applicant
    end
  end
=end
  def applicant_params
    params.require(:applicant).permit(:name, :email, :score_01, :score_02, :score_03, :score_04, :token, :challenge_id, :attachment, :id)
  end

end
