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
  docker build -t yourname/app ./svelte-app
  docker tag yourname/app 
  docker push yourname/app

docker-pocketbase:
  docker build -t yourname/pocketbase:0.35.0 ./pocketbase
  docker tag yourname/pocketbase:0.35.0 yourname/pocketbase:latest
  docker push yourname/pocketbase:0.35.0
  docker push yourname/pocketbase:latest


 