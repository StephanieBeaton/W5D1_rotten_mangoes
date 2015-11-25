class MoviesController < ApplicationController

  def index
    # @movies = Movie.all.page(params[:page]).per(10)
    # @products = Product.order("name").page(params[:page]).per(5)
    # @movies = Movie.all
    @movies = Movie.page(params[:page]).per(10)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end


  def search
    # params = {:utf8 =>"✓",
    #            :title =>"Chicago",
    #            :commit =>"Search"}

    where_arg = ''
    if params[:title] != ''
      where_arg += 'title LIKE "' + "%#{params[:title]}" + '%" '
    end

    if params[:director] != ''
      if where_arg != ''
        where_arg += ' AND '
      end
      where_arg += 'director LIKE "' + "%#{params[:director]}" + '%" '
    end

    if params[:duration] != '0'

      # 1, "Under 90 minutes"
      # 2, "Between 90 and 120 minutes"
      # 3, "Over 120 minutes"

      if where_arg != '' && params[:duration] != "0" && params[:duration] != ""
        where_arg += ' AND '
      end

      case params[:duration]
      when "1"
        where_arg += 'runtime_in_minutes < 90'
      when "2"
        where_arg += 'runtime_in_minutes BETWEEN 90 AND 120 '
      when "3"
        where_arg += 'runtime_in_minutes > 120 '
      end

    end

    # User.where("name like :kw or description like :kw", :kw=>"%#{params[:query]}%").to_sql

    @movies = Movie.where(where_arg).page(params[:page]).per(10)
    render :index
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image, :remote_image_url
    )
  end

end
