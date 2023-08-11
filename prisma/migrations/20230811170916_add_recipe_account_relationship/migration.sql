-- CreateTable
CREATE TABLE "AccountRecipeRelationship" (
    "account_id" INTEGER NOT NULL,
    "recipe_id" INTEGER NOT NULL,

    CONSTRAINT "AccountRecipeRelationship_pkey" PRIMARY KEY ("account_id","recipe_id")
);

-- AddForeignKey
ALTER TABLE "AccountRecipeRelationship" ADD CONSTRAINT "AccountRecipeRelationship_account_id_fkey" FOREIGN KEY ("account_id") REFERENCES "account"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AccountRecipeRelationship" ADD CONSTRAINT "AccountRecipeRelationship_recipe_id_fkey" FOREIGN KEY ("recipe_id") REFERENCES "recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
