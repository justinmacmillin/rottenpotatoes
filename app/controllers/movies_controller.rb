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

    # anytime we don't use the params arguments we have to redirect the page to reflect the arugments in the url

    if params[:ratings]
        if params[:sort]
          @movies = Movie.find_all_by_rating(params[:ratings].keys)
          @movies.sort_by!{|item|item.send(params[:sort])}
          session[:sort] = params[:sort]
        else
          rating = params[:ratings]
          session[:ratings] = params[:ratings]
          movieKeys = rating.keys
          @movies = Movie.find_all_by_rating(movieKeys)
        end
    elsif session[:ratings]
        if session[:sort]
          @movies = Movie.find_all_by_rating(session[:ratings].keys)
          @movies.sort_by!{|item|item.send(session[:sort])}
          redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings])
        else
          redirect_to movies_path(:sort => params[:sort], :ratings => session[:ratings])
        end
    elsif session[:sort] or params[:sort]
      if params[:sort]
        @movies = Movie.all
        @movies.sort_by!{|item|item.send(params[:sort])}
        session[:sort] = params[:sort]
      else
        @movies = Movie.all
        @movies.sort_by!{|item|item.send(session[:sort])}
        redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings])
      end
    else
      @movies = Movie.all
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
