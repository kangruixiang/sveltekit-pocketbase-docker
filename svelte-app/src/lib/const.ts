import { env } from '$env/dynamic/public';
import { browser } from '$app/environment';

import PocketBase from 'pocketbase';

// Pocketbase login
export const superUser = 'admin@pocketbase.com'; 
// replace with your username
export const superUserPass = 'password123';
// replace with your password

// Pocketbase url for files
export const baseURL = 'http://127.0.0.1:8090/api/files';

// Determine the correct URL based on whether we are running in dev and whether we are in the browser or server
const isDev = import.meta.env.DEV;
console.log('isDev:', isDev);
console.log('isBrowser', browser);
console.log('pocketbase public:', env.PUBLIC_POCKETBASE_URL);
console.log('pocketbase internal', env.PUBLIC_INTERNAL_POCKETBASE_URL);

export const pbURL = isDev
	? env.PUBLIC_POCKETBASE_URL // Dev sees localhost
	: browser
		? env.PUBLIC_POCKETBASE_URL // Browser in prod sees public URL
		: env.PUBLIC_INTERNAL_POCKETBASE_URL; // Server in prod sees Docker URL

console.log('pbURL:', pbURL);

export const pb = new PocketBase(pbURL);


/**
 * Authorizes pocketbase
 */
export async function getAuth() {
	await pb.collection('_superusers').authWithPassword(superUser, superUserPass);
	console.log('Logged in to Pocket client: ', pb.authStore.isValid);
}

/**
 * Replaces local url with remote url if different
 */
export function replacePbUrl(content: string) {
	if (!content) return '';
	if (pbURL == 'http://127.0.0.1:8090') return content;
	return content.replace(/http:\/\/127\.0\.0\.1:8090/g, pbURL);
}