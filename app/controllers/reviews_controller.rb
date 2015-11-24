
class ReviewsController < ApplicationController

  before_filter :load_movie

  # Filters are simply methods that run before, after, or "around"
  # each controller action.
  # In our ReviewsController,
  # we have the same line at the beginning of both actions:

  def new
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build
  end

  def create
    @movie = Movie.find(params[:movie_id])
    # below is same as @review = Review.new(movie_id: @movie.id)
    @review = @movie.reviews.build(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_to @movie, notice: "Review created successfully"
    else
      render :new
    end
  end

  protected

  def load_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:text, :rating_out_of_ten)
  end

end
