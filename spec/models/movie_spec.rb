require 'spec_helper'

describe Movie do

  let(:movie) { Movie.create!(title: 'Dogma', director: 'Kevin Smith') }

  describe '#find_by_director' do

    it "returns nil if movie has no director" do
      movie.director = ''
      movie.find_by_director.should be_nil
    end

    context "when another movie has the same director" do
      it "returns list with this movie" do
        other = Movie.create!(title: 'Clerks', director: 'Kevin Smith')
        movie.find_by_director.should eq [other]
      end
    end

    context "when no movie has the same director" do
      it "returns an empty list" do
        movie.find_by_director.should be_empty
      end
    end

  end

end
