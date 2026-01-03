# Set shell for Windows OSs:
# set windows-shell := ['cmd', '/c']
# set windows-shell := ["C:/Program Files/Git/usr/bin/bash.exe", "-c"]
set windows-shell := ["powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command"]

default: 
  just --list --unsorted

install:
	concurrently "cd svelte-app && pnpm install" 
  
dev: 
  concurrently "cd pocketbase && pocketbase serve" "cd svelte-app && pnpm run dev"

start: 
  concurrently "cd pocketbase && pocketbase serve" "cd svelte-app && pnpm run start"

prod:
  concurrently "cd pocketbase && pocketbase serve" "cd svelte-app && node build"

docker-svelte-app:
  docker build -t kangruixiang/svelte-app:0.0.1 ./svelte-app
  docker tag kangruixiang/svelte-app:0.0.1 kangruixiang/svelte-app:latest
  docker push kangruixiang/svelte-app:0.0.1
  docker push kangruixiang/svelte-app:latest

docker-pocketbase:
  docker build -t kangruixiang/pocketbase:0.35.0 ./pocketbase
  docker tag kangruixiang/pocketbase:0.35.0 kangruixiang/pocketbase:latest
  docker push kangruixiang/pocketbase:0.35.0
  docker push kangruixiang/pocketbase:latest


 