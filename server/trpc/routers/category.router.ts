import CategoryService from "~~/lib/services/category.service";
import { memberProcedure, adminProcedure, publicProcedure, readWriteProcedure, router } from '../trpc';
import { z } from 'zod';

export const categoryRouter = router({
    getActive: publicProcedure
        .query(async () => {
            const categoriesService = new CategoryService();
            const categories = await categoriesService.getActive()
            return {
                categories
            }
        }),
    getById: publicProcedure
        .input(z.object({ category_id: z.number() }))
        .query(async ({ ctx, input }) => {
            const categoriesService = new CategoryService();
            const category = await categoriesService.getById(input.category_id); 
            return {
                category,
            }
        }),
    create: readWriteProcedure
        .input(z.object({ category_name: z.string() }))
        .mutation(async ({ctx, input}) => {
            const categoriesService = new CategoryService();
            const category = (ctx.activeAccountId)? await categoriesService.create(input.category_name):null;
            return { category, }
        }),
    delete: adminProcedure
        .input(z.object({category_id: z.number()}))
        .mutation(async ({ ctx, input }) => {
            console.log('hit')
            const categoriesService = new CategoryService();
            const category = (ctx.activeAccountId)? await categoriesService.delete(input.category_id):null;
            return {
                category
            }
        })
});