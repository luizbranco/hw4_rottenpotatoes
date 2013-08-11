require 'spec_helper'

describe Movie do

  let(:movie) { Movie.create!(title: 'Dogma', director: 'Kevin Smith') }

  describe '.all_ratings' do
    it { Movie.all_ratings.should eq ['G', 'PG', 'PG-13', 'NC-17', 'R'] }
  end

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
