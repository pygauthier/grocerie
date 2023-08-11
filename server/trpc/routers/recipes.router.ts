import RecipesService from '~~/lib/services/recipes.service';
import { accountHasSpecialFeature, adminProcedure, memberProcedure, publicProcedure, readWriteProcedure, router } from '../trpc';
import { z } from 'zod';

export const recipesRouter = router({
  getForActiveAccount: memberProcedure
    .query(async ({ ctx, input }) => {
      const recipesService = new RecipesService();
      const recipes = (ctx.activeAccountId)?await recipesService.getRecipesForAccountId(ctx.activeAccountId):[]; 
      return {
        recipes,
      }
    }),
  getById: publicProcedure
    .input(z.object({ recipe_id: z.number() }))
    .query(async ({ ctx, input }) => {
      const recipesService = new RecipesService();
      const recipe = await recipesService.getRecipeById(input.recipe_id); 
      return {
        recipe,
      }
    }),
  createRecipe: readWriteProcedure
    .input(z.object({ /** */ }))
    .mutation(async ({ ctx, input }) => {
      const recipesService = new RecipesService();
      const recipe = (ctx.activeAccountId)?await recipesService.createRecipe(ctx.activeAccountId, input):null; 
      return {
        recipe,
      }
    }),
  deleteRecipe: adminProcedure
    .input(z.object({ note_id: z.number() }))
    .mutation(async ({ ctx, input }) => {
      const recipesService = new RecipesService();
      const recipe = (ctx.activeAccountId)?await recipesService.deleteRecipe(input.note_id):null; 
      return {
        recipe,
      }
    }),
  /*
  generateAINoteFromPrompt: readWriteProcedure.use(accountHasSpecialFeature)
    .input(z.object({ user_prompt: z.string() }))
    .query(async ({ ctx, input }) => {
      const recipesService = new RecipesService();
      const noteText = (ctx.activeAccountId)?await recipesService.generateAINoteFromPrompt(input.user_prompt):null; 
      return {
        noteText
      }
    }),
  */
})