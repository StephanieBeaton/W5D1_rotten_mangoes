class Movie < ActiveRecord::Base

  has_many :reviews, :dependent => :destroy

  mount_uploader :image, ImageUploader

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  # validates :poster_image_url,
  #   presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    return 0 if reviews.size == 0
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  #  Example
  # scope :created_before, ->(time) { where("created_at < ?", time) }

  scope :title_like, ->(partial_title) { where("title LIKE ?", "%#{partial_title}%") }

  scope :director_like, ->(partial_director) { where("director LIKE ?", "%#{partial_director}%")}

  scope :title_like_or_director_like, ->(partial_dir_or_title) { where("title LIKE ? OR director LIKE ?", "%#{partial_dir_or_title}%", "%#{partial_dir_or_title}%")}

  scope :runtime_less_than, ->(runtime_limit) { where("runtime_in_minutes < ?", runtime_limit)}

  scope :runtime_greater_than, ->(runtime_limit) { where("runtime_in_minutes > ?", runtime_limit)}

  scope :runtime_between, ->(lower_bound, upper_bound) { where("runtime_in_minutes BETWEEN ? AND ?", lower_bound, upper_bound)}


  # On the movies page, instead of two separate text fields,
  # ... have only one search box that allows the user to search
  # ... for movies by title or director.

  # In that box, they can type in "John"
  # ... and movies directed by "John Hughes" would come up (eg: "The Breakfast Club")
  # ... as well as a movie with "John" in the name (eg: "Being John Malkovich")

  def self.search(params)
    @movies = Movie.all

    if params[:titleordirector] != ''
      @movies = @movies.title_like_or_director_like(params[:titleordirector])
    end

    # 1, "Under 90 minutes"
    # 2, "Between 90 and 120 minutes"
    # 3, "Over 120 minutes"

    case params[:duration]
    when "1"
      @movies = @movies.runtime_less_than(90)
    when "2"
      @movies = @movies.runtime_between(90, 120)
    when "3"
      @movies = @movies.runtime_greater_than(120)
    end

    @movies
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end
