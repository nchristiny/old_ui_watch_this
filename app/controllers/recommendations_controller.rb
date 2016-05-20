class RecommendationsController < ApplicationController
  before_filter :load_recommendation_entry, only: [:show, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def index
    @recommendations = Recommendation.all
  end

  def show
  end

  def new
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = Recommendation.new(params[:recommendation])
    if @recommendation.save
      flash[:success] = "Thank you. After crunching the numbers, we have determined this film to be your optimal choice. Enjoy!"
      render json: @recommendation
    else
      flash.now[:failure] = "Submission failed!"
      render :new
    end
  end

  def destroy
    @recommendation.destroy
    # redirect_to recommendations_path
    head :no_content
  end

  private

    def load_recommendation_entry
      @recommendation = Recommendation.find(params[:id]) if params[:id].present?
    end

    def recommendation_params
      params.require(:recommendation).permit(:winning_title, :genres_pref, :rating_pref, :director_pref, :decade_pref, :stars_pref, :keywords_pref)
    end

end
