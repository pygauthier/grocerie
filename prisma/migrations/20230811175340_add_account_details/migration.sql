/*
  Warnings:

  - You are about to drop the `_ingredient_recipe_ingredient_relationship` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_recipe_ingredient_recipe_relationship` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_tag_recipe_relationship` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_ingredient_recipe_ingredient_relationship" DROP CONSTRAINT "_ingredient_recipe_ingredient_relationship_ingredient_id_fkey";

-- DropForeignKey
ALTER TABLE "_ingredient_recipe_ingredient_relationship" DROP CONSTRAINT "_ingredient_recipe_ingredient_relationship_recipeingredien_fkey";

-- DropForeignKey
ALTER TABLE "_recipe_ingredient_recipe_relationship" DROP CONSTRAINT "_recipe_ingredient_recipe_relationship_recipe_id_fkey";

-- DropForeignKey
ALTER TABLE "_recipe_ingredient_recipe_relationship" DROP CONSTRAINT "_recipe_ingredient_recipe_relationship_recipeingredient_id_fkey";

-- DropForeignKey
ALTER TABLE "_tag_recipe_relationship" DROP CONSTRAINT "_tag_recipe_relationship_recipe_id_fkey";

-- DropForeignKey
ALTER TABLE "_tag_recipe_relationship" DROP CONSTRAINT "_tag_recipe_relationship_tag_id_fkey";

-- AlterTable
ALTER TABLE "account" ADD COLUMN     "max_recipes" INTEGER NOT NULL DEFAULT 100;

-- DropTable
DROP TABLE "_ingredient_recipe_ingredient_relationship";

-- DropTable
DROP TABLE "_recipe_ingredient_recipe_relationship";

-- DropTable
DROP TABLE "_tag_recipe_relationship";

-- CreateTable
CREATE TABLE "_recipe_ingredientRecipeRelationship" (
    "recipeingredient_id" INTEGER NOT NULL,
    "recipe_id" INTEGER NOT NULL,

    CONSTRAINT "_recipe_ingredientRecipeRelationship_pkey" PRIMARY KEY ("recipeingredient_id","recipe_id")
);

-- CreateTable
CREATE TABLE "IngredientRecipeIngredientRelationship" (
    "ingredient_id" INTEGER NOT NULL,
    "recipeingredient_id" INTEGER NOT NULL,

    CONSTRAINT "IngredientRecipeIngredientRelationship_pkey" PRIMARY KEY ("ingredient_id","recipeingredient_id")
);

-- CreateTable
CREATE TABLE "TagRecipeRelationship" (
    "tag_id" INTEGER NOT NULL,
    "recipe_id" INTEGER NOT NULL,

    CONSTRAINT "TagRecipeRelationship_pkey" PRIMARY KEY ("tag_id","recipe_id")
);

-- AddForeignKey
ALTER TABLE "_recipe_ingredientRecipeRelationship" ADD CONSTRAINT "_recipe_ingredientRecipeRelationship_recipeingredient_id_fkey" FOREIGN KEY ("recipeingredient_id") REFERENCES "recipeingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_recipe_ingredientRecipeRelationship" ADD CONSTRAINT "_recipe_ingredientRecipeRelationship_recipe_id_fkey" FOREIGN KEY ("recipe_id") REFERENCES "recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IngredientRecipeIngredientRelationship" ADD CONSTRAINT "IngredientRecipeIngredientRelationship_ingredient_id_fkey" FOREIGN KEY ("ingredient_id") REFERENCES "ingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IngredientRecipeIngredientRelationship" ADD CONSTRAINT "IngredientRecipeIngredientRelationship_recipeingredient_id_fkey" FOREIGN KEY ("recipeingredient_id") REFERENCES "recipeingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TagRecipeRelationship" ADD CONSTRAINT "TagRecipeRelationship_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TagRecipeRelationship" ADD CONSTRAINT "TagRecipeRelationship_recipe_id_fkey" FOREIGN KEY ("recipe_id") REFERENCES "recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
