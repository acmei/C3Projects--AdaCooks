class RecipesController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  include ApplicationHelper

  def index
    @recipes = Recipe.alpha
  end

  def show
    @ingredients = @recipe.ingredients
  end

  def new
    @recipe = Recipe.new
    @url = recipes_path
    @method = :post
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: "Recipe successfully added chef!"
    else
      flash.now[:error] = "Error!!"
      render :new
    end
  end

  def edit
    @url = recipe_path(@recipe)
    @method = :patch
    @user = current_user
  end

  def update
    @recipe.update(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: "You so fancy!"
    else
      flash.now[:error] = "Throw yo hands in the ERROR!!"
      render :new
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "#{@recipe} is no more :("
  end

  def search
    @recipes = Recipe.search params[:search]
    render :search_results
  end

  private

  def set_user
    @user = current_user
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :desc, :prep, :image, :cookbook_id, :cookbook_ids, :user_id, :ingredient_ids => [], ingredients_attributes: [:name], :cookbook_ids => [])
  end
end
