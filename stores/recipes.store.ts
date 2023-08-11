import { Recipe } from ".prisma/client"
import { defineStore, storeToRefs } from "pinia"
import { Ref } from "vue";

/*
Note) the Notes Store needs to be a 'Setup Store' (https://pinia.vuejs.org/core-concepts/#setup-stores)
because this enables the use of the watch on the Account Store
If the UI does not need to dynamically respond to a change in the active Account e.g. if state is always retrieved with an explicit fetch after onMounted.
then an Options store can be used.
*/
export const useRecipesStore = defineStore('recipes', () => {
  const accountStore = useAccountStore()
  const { activeAccountId } = storeToRefs(accountStore);

  let _recipes: Ref<Recipe[]> = ref([]);
  
  async function fetchNotesForCurrentUser() {
    const { $client } = useNuxtApp();
    const { recipes } = await $client.recipes.getForActiveAccount.query();
    if(recipes){
      _recipes.value = recipes;
    }  
  }

  async function createRecipe(payload: string) {
    const { $client } = useNuxtApp();
    const { recipe } =  await $client.recipes.createRecipe.mutate(payload);
    if(recipe){
      _recipes.value.push(recipe);
    }
  }

  async function deleteRecipe(note_id: number) {
    const { $client } = useNuxtApp();
    const { recipe } =  await $client.recipes.deleteRecipe.mutate({note_id});
    if(recipe){
      _recipes.value = _recipes.value.filter(n => n.id !== recipe.id);
    }
  }

  /*
  async function generateAINoteFromPrompt(user_prompt: string) {
    const { $client } = useNuxtApp();
    const { noteText } =  await $client.notes.generateAINoteFromPrompt.query({user_prompt});
    return noteText?noteText:'';
  }
  */

  // if the active account changes, fetch notes again (i.e dynamic.. probabl overkill)
  watch(activeAccountId, async (val, oldVal)=> {
    await fetchNotesForCurrentUser()
  });

  return { notes: _recipes, fetchNotesForCurrentUser, createRecipe, deleteRecipe}
});
