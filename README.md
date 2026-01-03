# sveltekit-pocketbase-docker

Template for Sveltekit + Pocketbase, dockerized.

After much pain, trial, and error, I have made it work.

## Installation

- clone repository
- install [just](https://github.com/casey/just)
- install dependencies: `just install`

## How This Works

To make Pocketbase play well in Docker, you have to change the URL depends on whether you are accessing Pocketbase via browser or server, local or remote. There are three scenarios:

### Local Dev

This is when you are just running local sveltekit development. Pocketbase should be accessed with `http://localhost:8090`. 

### Local Docker

This is when you docker compose up on the same development machine. Pocketbase should be `http://localhost:8090` when accessed via browser and `http://pocketbase:8090` when accessed via server.

### Remote Deploy

This is when you docker compose up on remote server such as NAS. Pocketbase should be the remote IP when accessed via browser and `http://pocketbase:8090` when accessed in server.

`const.ts` file under svelte-app/lib folder automates this process and changes pbURL depends on where pocketbase is accessed. You can also use `replacePbUrl` function in the file to change Pocketbase url anywhere in the app. 

### CSP

Under `hooks.server.ts`, PbURL is added to avoid running into problem.

## Setup

- rename `.env_example` to `.env` under svelte-app, you should have `PUBLIC_POCKETBASE_URL` and 
`PUBLIC_INTERNAL_POCKETBASE_URL`. This file is used in local development. You don't have to change anything here. 
- in docker-compose.yml, you should also have `PUBLIC_POCKETBASE_URL` and 
`PUBLIC_INTERNAL_POCKETBASE_URL`. These are accessed when you docker compose up. On your local machine, you should keep everything as is. When you deploy to a remote server, change `PUBLIC_POCKETBASE_URL` to the remote IP wherever you deploy it. For example, I use tailscale to deploy apps to my home NAS system. So my url is `http://homenas:8090`.

## Start

In local dev, use `just dev` command. Use `docker compose up` to deploy to docker.

Once the app is running, open up dev tool and console in browser, and you should see message: "Logged in to Pocket client:  true"