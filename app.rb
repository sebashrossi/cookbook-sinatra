require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'recipe'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  cookbook = Cookbook.new('recipes.csv')
  @recipes = cookbook.all
  erb :index
end

post '/recipes' do
  @recipe_title = params[:recipeTitle]
  @recipe_body = params["recipeBody"]
  cookbook = Cookbook.new('recipes.csv')
  recipe = Recipe.new(@recipe_title, @recipe_body)
  cookbook.add(recipe)
  redirect "/"
end

get '/create' do
  erb :create
end
