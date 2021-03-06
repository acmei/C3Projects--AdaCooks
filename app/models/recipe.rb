class Recipe < ActiveRecord::Base
# ASSOCIATIONS ----------------------------------------
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :cookbooks, :join_table => "cookbooks_recipes"
  belongs_to :user

# VALIDATIONS -----------------------------------------
  validates :name, presence: true
  validates :prep, presence: true
  validate :req_ingredients

  def req_ingredients
    unless ingredients.length > 0
      errors.add(:ingredients, "Need at least one ingredient in your recipe")
    end
  end
# SCOPES ----------------------------------------------
  scope :alpha, -> { order("name ASC") }

# MOUNT UPLOADER --------------------------------------
  mount_uploader :image, ImageUploader

end
