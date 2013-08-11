require 'spec_helper'

describe MoviesController do

  let(:movie) { stub(title: 'Dogma') }

  describe '#same_director' do

    before do
      Movie.stub(:find).and_return(movie)
    end

    context "when movie has a director" do

      before do
        movie.stub(:find_by_director).and_return([])
        get :same_director, id: 1
      end

      it { should render_template 'same_director' }
    end

    context "when movie has no director info" do

      before do
        movie.stub(:find_by_director).and_return(nil)
        get :same_director, id: 1
      end

      it { should redirect_to root_path }
      it { flash[:notice].should_not be_nil }
    end

  end

end
