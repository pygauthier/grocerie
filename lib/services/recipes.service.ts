import prisma_client from '~~/prisma/prisma.client';
import { openai } from './openai.client';
import { AccountLimitError } from './errors';
import { Dict } from '@trpc/server';

export default class RecipesService {
	async createRecipe( account_id: number, recipe_payload: any ) {
		const account = await prisma_client.account.findFirstOrThrow({
			where: { id: account_id},
			include: { recipes: true}
		});

		if(account.recipes.length>= account.max_recipes){
			throw new AccountLimitError('Note Limit reached, no new recipes can be added');
		}
		
		return prisma_client.recipe.create({ data: recipe_payload});
	}

	async getAllRecipe() {
		return prisma_client.recipe.findMany();
	}

	async getRecipeById(id: number) {
		return prisma_client.recipe.findUniqueOrThrow({ where: { id } });
	}

	async getRecipesForAccountId(account_id: number) {
		return prisma_client.recipe.findMany({
			where: { 
				account: { some: {account_id : account_id}} 
			}
		});
	}

	async updateRecipe(id: number, updated_field: any) {
		return prisma_client.recipe.update({ where: { id }, data: updated_field });
	}

	async deleteRecipe(id: number) {
		return prisma_client.recipe.delete({ where: { id } });
	}
	/*

	async generateAIRecipeFromPrompt(userPrompt: string) {
		const prompt = `
		Write an interesting short note about ${userPrompt}.  
		Restrict the note to a single paragraph.
		`
		const completion = await openai.createCompletion({
			model: "text-davinci-003",
			prompt,
			temperature: 0.6,
			stop: "\n\n",
			max_tokens: 1000,
			n: 1,
		});
		return completion.data.choices[0].text;
	}
	*/
}
