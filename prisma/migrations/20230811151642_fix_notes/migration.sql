-- CreateTable
CREATE TABLE "recipe" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "prep_time" INTEGER NOT NULL,
    "cook_time" INTEGER NOT NULL,
    "servings" INTEGER NOT NULL DEFAULT 1,
    "intro" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,
    "category_id" INTEGER,

    CONSTRAINT "recipe_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecipeIngredientRecipeRelationship" (
    "recipeingredient_id" INTEGER NOT NULL,
    "recipe_id" INTEGER NOT NULL,

    CONSTRAINT "RecipeIngredientRecipeRelationship_pkey" PRIMARY KEY ("recipeingredient_id","recipe_id")
);

-- CreateTable
CREATE TABLE "category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ingredient" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "unit" TEXT NOT NULL,

    CONSTRAINT "ingredient_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recipeingredient" (
    "id" SERIAL NOT NULL,
    "amount" INTEGER NOT NULL,
    "scaling" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "recipeingredient_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "IngredientRecipeIngredientRelationship" (
    "ingredient_id" INTEGER NOT NULL,
    "recipeingredient_id" INTEGER NOT NULL,

    CONSTRAINT "IngredientRecipeIngredientRelationship_pkey" PRIMARY KEY ("ingredient_id","recipeingredient_id")
);

-- CreateTable
CREATE TABLE "meal" (
    "id" SERIAL NOT NULL,
    "day" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "servings" INTEGER,
    "recipe_id" INTEGER NOT NULL,

    CONSTRAINT "meal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "grocery" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "grocery_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tag" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TagRecipeRelationship" (
    "tag_id" INTEGER NOT NULL,
    "recipe_id" INTEGER NOT NULL,

    CONSTRAINT "TagRecipeRelationship_pkey" PRIMARY KEY ("tag_id","recipe_id")
);

-- AddForeignKey
ALTER TABLE "recipe" ADD CONSTRAINT "recipe_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecipeIngredientRecipeRelationship" ADD CONSTRAINT "RecipeIngredientRecipeRelationship_recipeingredient_id_fkey" FOREIGN KEY ("recipeingredient_id") REFERENCES "recipeingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecipeIngredientRecipeRelationship" ADD CONSTRAINT "RecipeIngredientRecipeRelationship_recipe_id_fkey" FOREIGN KEY ("recipe_id") REFERENCES "recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IngredientRecipeIngredientRelationship" ADD CONSTRAINT "IngredientRecipeIngredientRelationship_ingredient_id_fkey" FOREIGN KEY ("ingredient_id") REFERENCES "ingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IngredientRecipeIngredientRelationship" ADD CONSTRAINT "IngredientRecipeIngredientRelationship_recipeingredient_id_fkey" FOREIGN KEY ("recipeingredient_id") REFERENCES "recipeingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "meal" ADD CONSTRAINT "meal_recipe_id_fkey" FOREIGN KEY ("recipe_id") REFERENCES "recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TagRecipeRelationship" ADD CONSTRAINT "TagRecipeRelationship_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TagRecipeRelationship" ADD CONSTRAINT "TagRecipeRelationship_recipe_id_fkey" FOREIGN KEY ("recipe_id") REFERENCES "recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
