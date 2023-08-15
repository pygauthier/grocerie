/**
 * This is the API-handler of your app that contains all your API routes.
 * On a bigger app, you will probably want to split this file up into multiple files.
 */
import { createNuxtApiHandler } from 'trpc-nuxt'

import { router } from '~/server/trpc/trpc'
import { createContext } from '~~/server/trpc/context';
import { notesRouter } from '~~/server/trpc/routers/notes.router';
import { recipesRouter } from '~~/server/trpc/routers/recipes.router';
import { authRouter } from '~~/server/trpc/routers/auth.router';
import { accountRouter } from '~~/server/trpc/routers/account.router';
import { categoryRouter } from '~~/server/trpc/routers/category.router';

console.log(categoryRouter)
export const appRouter = router({
  notes: notesRouter,
  recipes: recipesRouter,
  auth: authRouter,
  account: accountRouter,
  category: categoryRouter,
})

// export only the type definition of the API
// None of the actual implementation is exposed to the client
export type AppRouter = typeof appRouter;

// export API handler
export default createNuxtApiHandler({
  router: appRouter,
  createContext: createContext,
  onError({ error}) { console.error(error)}, 
})
