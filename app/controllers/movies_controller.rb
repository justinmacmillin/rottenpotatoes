class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def all_ratings
    @all_ratings = ['G','PG','PG-13','R', 'NC-17']
  end

  def index
    if params[:ratings].nil?
      @movies = Movie.all
    else
      rating = params[:ratings]
      session[:ratings] = params[:ratings]
      movieKeys = rating.keys
      @movies = Movie.find_all_by_rating(movieKeys)
    end

    if params[:sort]
      session[:sort] = params[:sort]
    end

    if params[:sort] or session[:sort]
      sort = params[:sort] || session[:sort]
      @movies.sort_by!{|item|item.send(sort)}
    end
    all_ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
