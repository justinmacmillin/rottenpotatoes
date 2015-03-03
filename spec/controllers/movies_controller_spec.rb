require 'spec_helper'

describe MoviesController do


  before :all do
    @star = Movie.create!(:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '25-May-1977')
    @blade = Movie.create!(:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '25-Jun-1982')
    @alien = Movie.create!(:title => 'Alien', :rating => 'R', :director => nil, :release_date => '25-May-1979')
    @thx = Movie.create!(:title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '11-Mar-1971')
  end

  describe 'test create' do
    it 'should create the movie' do
      @new_movie = Movie.create!(:title => 'new', :rating => 'G', :director => 'no one', :release_date => '25-May-1977')
      @new_movie.should_not be_nil
    end
  end

  describe 'test edit' do

    it 'should change the name of the movie' do
      @star[:title] = 'Star Wars, Episode 2'
      @star[:title].should == 'Star Wars, Episode 2'
    end

  end

  describe 'test update' do

    it 'should update director of the movie' do
      @blade[:director] = 'Justin MacMillin'
      @blade[:director].should_not == nil
    end

  end

  describe 'test destroy' do

    it 'should delete the movie' do
      delete @new_movie
      @new_movie.should be_nil
    end

  end

end
