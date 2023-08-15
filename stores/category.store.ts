import { Category } from "@prisma/client";
import { defineStore } from "pinia";
import { Ref } from "vue";

interface State {
    data: []
}

export const  useCategoriesStore = defineStore('categories', {
    state: (): State => {
        return {
            data: [],
        }
    },
    getters: {
        all: (state) => state.data
    },
    actions: {
        async create(category_name: string) {
            const { $client } = useNuxtApp();
            const { category } = await $client.category.create.mutate({category_name});
            if(category){
                this.data.push(category);
            }
            return this.data
        },
        async fetch() {
            const { $client } = useNuxtApp();
            const { categories } = await $client.category.getActive.query();
            if(categories){
                this.data = categories;
            }
        },
        async delete(category_id: number) {
            const { $client } = useNuxtApp();
            const { category } = await $client.category.delete.mutate({category_id});
            if(category) {
                this.data = this.data.filter(c => c.id !== category.id);
            }
        }
    }
});
