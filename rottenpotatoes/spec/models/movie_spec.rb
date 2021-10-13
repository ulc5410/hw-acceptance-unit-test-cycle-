require 'rails_helper'
require 'patch'

describe Movie do
    it "responds to movie_with_id" do
        Movie.should respond_to(:movie_with_id)
    end

    it "responds to get_similar_movies" do
        Movie.should respond_to(:get_similar_movies)
    end

    describe "movie of same director - happy path" do
        it "should have the movies with same director and should not have movie with different director" do
            Movie.create('title': 'movie1', 'director': 'director1')
            id_1 =  Movie.where('director': 'director1').pluck('id')[0]
            Movie.create('title': 'movie2', 'director': 'director1') 
            Movie.create('title': 'movie3', 'director': 'director2')
            expect( Movie.get_similar_movies(id_1.to_s).pluck(:title) ).to include('movie1')
            expect( Movie.get_similar_movies(id_1.to_s).pluck(:title) ).to include('movie2')
            expect( Movie.get_similar_movies(id_1.to_s).pluck(:title) ).not_to include('movie3')
        end
    end

    describe "movie of same diretor - sad path" do
        it "movie with no director should return nil" do
            Movie.create('title': 'movie1', 'director': "")
            id_1 =  (Movie.where('director': 'director').pluck('id')[0]).to_s
            expect(Movie.get_similar_movies(id_1)).to eq(nil)
        end
    end
end 