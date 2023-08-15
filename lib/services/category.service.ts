import prisma_client from '~~/prisma/prisma.client';

export default class CategoryService {
    async create(name: string) {
        return prisma_client.category.create({data: {name}})
    }
    
    async getAll() {
        return prisma_client.category.findMany();
    }

    async getActive() {
        return prisma_client.category.findMany({where: {active: true}});
    }
    async getById(id: number) {
		return prisma_client.category.findUniqueOrThrow({ where: { id } });
	}

    async update(id:number, name: string) {
        return prisma_client.category.update({where: {id}, data: {name}});
    }

    async delete(id: number) {
        return prisma_client.category.delete({where: {id}})
    }
}