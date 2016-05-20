class FilmsController < ApplicationController
  before_filter :load_film_entry, only: [:show]

  def index
    @films_array = Film.all
    # Construct Array into a paginatable object for kaminari gem
    @films = Kaminari.paginate_array(@films_array).page(params[:page]).per(10)
  end

  def show
  end

  private

  def load_film_entry
    @film = Film.find(params[:id]) if params[:id].present?
  end
end
