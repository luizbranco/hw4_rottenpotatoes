require 'spec_helper'

describe MoviesController do

  let(:movie) { double(id: 1, title: 'Dogma') }
  before do
    Movie.stub(:find).and_return(movie)
    Movie.stub(all_ratings: ['PG'], order: [])
  end

  describe '#index' do

    context 'when there is no sorting and ratings' do
      before { get :index }
      it { should render_template 'index' }
    end

    context 'when there is sorting by release_date' do
      before { get :index, sort: :release_date }
    end

  end

  describe '#show' do
    before { get :show, id: movie.id }
    it { should render_template 'show' }
  end

  describe '#new' do
    before { get :new }
    it { should render_template 'new' }
  end

  describe '#edit' do
    before { get :edit, id: movie.id }
    it { should render_template 'edit' }
  end

  describe '#create' do
    before { post :create }

    it "calls destroy model" do
      Movie.should_receive(:create!).and_return(movie)
      post :create
    end

    it { should redirect_to movies_path }
    it { flash[:notice].should_not be_nil }
  end

  describe '#update' do
    before do
      movie.stub(:update_attributes!)
      put :update, id: movie.id
    end

    it "calls destroy model" do
      movie.should_receive(:update_attributes!)
      put :update, id: movie.id
    end

    it { should redirect_to movie_path(movie) }
    it { flash[:notice].should_not be_nil }
  end

  describe '#destroy' do

    before do
      movie.stub(:destroy)
      delete :destroy, id: movie.id
    end

    it "calls destroy model" do
      movie.should_receive(:destroy)
      delete :destroy, id: movie.id
    end

    it { should redirect_to movies_path }
    it { flash[:notice].should_not be_nil }
  end

  describe '#same_director' do

    context "when movie has a director" do

      before do
        movie.stub(:find_by_director).and_return([])
        get :same_director, id: movie.id
      end

      it { should render_template 'same_director' }
    end

    context "when movie has no director info" do

      before do
        movie.stub(:find_by_director).and_return(nil)
        get :same_director, id: movie.id
      end

      it { should redirect_to root_path }
      it { flash[:notice].should_not be_nil }
    end

  end

end
