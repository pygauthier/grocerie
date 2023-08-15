<script setup lang="ts">
  import { storeToRefs } from 'pinia';
  import { ACCOUNT_ACCESS } from '~~/prisma/account-access-enum';

  definePageMeta({
	middleware: ['auth'],
  });


  const accountStore = useAccountStore();
  const { activeMembership } = storeToRefs(accountStore)  
  const categoriesStore = useCategoriesStore();
  const newCategoryText = ref('');

  async function addCategory(){
	console.log('enter addCategory', newCategoryText.value)
	await categoriesStore.create(newCategoryText.value);
	newCategoryText.value = '';
  }

  onMounted(async () => {
	await accountStore.init();
	await categoriesStore.fetch();
  }); 
</script>
<template>
	<div class="flex flex-col items-center max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:py-16 lg:px-8">
		<div class="w-full max-w-md">
			<div class="overflow-x-auto">
				<div v-if="activeMembership && (activeMembership.access === ACCOUNT_ACCESS.READ_WRITE || activeMembership.access === ACCOUNT_ACCESS.ADMIN || activeMembership.access === ACCOUNT_ACCESS.OWNER)">
					<input type="text" v-model="newCategoryText" placeholder="Category Name" class="input input-bordered input-secondary w-full max-w-xs px-4 py-4" />
					<button @click.prevent="addCategory()" class="px-4 py-4 btn btn-primary"> Add </button>
				</div>
				<table class="table">
					<thead>
						<tr>
							<th>Name</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="category in categoriesStore.all" class="hover">
							<th>{{ category.name }}</th>
							<th>
								<div v-if="activeMembership && (activeMembership.access === ACCOUNT_ACCESS.ADMIN || activeMembership.access === ACCOUNT_ACCESS.OWNER)">
									<button @click.prevent="categoriesStore.delete(category.id)" class="btn btn-primary">
										Delete
									</button>
								</div>
							</th>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
  </div>
</template>
