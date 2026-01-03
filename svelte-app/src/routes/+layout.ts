import { getAuth } from '$lib/const'

export async function load() {
    await getAuth()
}