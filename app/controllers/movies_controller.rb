require_relative '../../lib/filter_by.rb'
require_relative '../../lib/filter_cache.rb'
class MoviesController < ApplicationController
  before_filter :restful_redirect, only: :index

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort_column = Movie.column_names.include?(cache.load(:sort)) ? cache.load(:sort) : "id"
    @filter = FilterBy.new(Movie)
    @movies = @filter.rating(cache.load(:ratings)).order(@sort_column)
    @all_ratings = Movie.all_ratings
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

  def same_director
    @movie = Movie.find(params[:id])
    @movies = @movie.find_by_director
    unless @movies
      flash[:notice] = "'#{@movie.title}' has no director info"
      redirect_to root_path and return
    end
  end

  private

  def cache
    cache = FilterCache.new(session)
    cache.save(params)
    cache
  end

  def restful_redirect
    s, p = session, params
    if s[:sort] && !p[:sort]
      redirect_to movies_path(sort: s[:sort], ratings: (p[:ratings] || s[:ratings]))
    elsif s[:ratings] && !p[:ratings]
      redirect_to movies_path(sort: (p[:sort] || s[:sort]), ratings: s[:ratings])
    end
    return
  end

end
