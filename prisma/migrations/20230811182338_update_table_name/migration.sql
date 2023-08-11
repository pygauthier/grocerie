/*
  Warnings:

  - You are about to drop the `IngredientRecipeIngredientRelationship` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TagRecipeRelationship` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_recipe_ingredientRecipeRelationship` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "IngredientRecipeIngredientRelationship" DROP CONSTRAINT "IngredientRecipeIngredientRelationship_ingredient_id_fkey";

-- DropForeignKey
ALTER TABLE "IngredientRecipeIngredientRelationship" DROP CONSTRAINT "IngredientRecipeIngredientRelationship_recipeingredient_id_fkey";

-- DropForeignKey
ALTER TABLE "TagRecipeRelationship" DROP CONSTRAINT "TagRecipeRelationship_recipe_id_fkey";

-- DropForeignKey
ALTER TABLE "TagRecipeRelationship" DROP CONSTRAINT "TagRecipeRelationship_tag_id_fkey";

-- DropForeignKey
ALTER TABLE "_recipe_ingredientRecipeRelationship" DROP CONSTRAINT "_recipe_ingredientRecipeRelationship_recipe_id_fkey";

-- DropForeignKey
ALTER TABLE "_recipe_ingredientRecipeRelationship" DROP CONSTRAINT "_recipe_ingredientRecipeRelationship_recipeingredient_id_fkey";

-- DropTable
DROP TABLE "IngredientRecipeIngredientRelationship";

-- DropTable
DROP TABLE "TagRecipeRelationship";

-- DropTable
DROP TABLE "_recipe_ingredientRecipeRelationship";

-- CreateTable
CREATE TABLE "_recipe_ingredient_recipe_relationship" (
    "recipeingredient_id" INTEGER NOT NULL,
    "recipe_id" INTEGER NOT NULL,

    CONSTRAINT "_recipe_ingredient_recipe_relationship_pkey" PRIMARY KEY ("recipeingredient_id","recipe_id")
);

-- CreateTable
CREATE TABLE "_ingredient_recipe_ingredient_relationship" (
    "ingredient_id" INTEGER NOT NULL,
    "recipeingredient_id" INTEGER NOT NULL,

    CONSTRAINT "_ingredient_recipe_ingredient_relationship_pkey" PRIMARY KEY ("ingredient_id","recipeingredient_id")
);

-- CreateTable
CREATE TABLE "_tag_recipe_relationship" (
    "tag_id" INTEGER NOT NULL,
    "recipe_id" INTEGER NOT NULL,

    CONSTRAINT "_tag_recipe_relationship_pkey" PRIMARY KEY ("tag_id","recipe_id")
);

-- AddForeignKey
ALTER TABLE "_recipe_ingredient_recipe_relationship" ADD CONSTRAINT "_recipe_ingredient_recipe_relationship_recipeingredient_id_fkey" FOREIGN KEY ("recipeingredient_id") REFERENCES "recipeingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_recipe_ingredient_recipe_relationship" ADD CONSTRAINT "_recipe_ingredient_recipe_relationship_recipe_id_fkey" FOREIGN KEY ("recipe_id") REFERENCES "recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ingredient_recipe_ingredient_relationship" ADD CONSTRAINT "_ingredient_recipe_ingredient_relationship_ingredient_id_fkey" FOREIGN KEY ("ingredient_id") REFERENCES "ingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ingredient_recipe_ingredient_relationship" ADD CONSTRAINT "_ingredient_recipe_ingredient_relationship_recipeingredien_fkey" FOREIGN KEY ("recipeingredient_id") REFERENCES "recipeingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_tag_recipe_relationship" ADD CONSTRAINT "_tag_recipe_relationship_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_tag_recipe_relationship" ADD CONSTRAINT "_tag_recipe_relationship_recipe_id_fkey" FOREIGN KEY ("recipe_id") REFERENCES "recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
