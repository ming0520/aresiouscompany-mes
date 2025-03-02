cd C:\GithubProject\mes-module

# RUN AS ADMIN
Set-ExecutionPolicy RemoteSigned -Scope Process
Set-ExecutionPolicy RemoteSigned

#USE THIS ONLY: https://tailwindcss.com/docs/installation/using-vite
#MORE REFERENCE:
#https://www.youtube.com/watch?v=7xll3A4_jeo&t=135s
#https://dev.to/osalumense/install-tailwind-css-v4-in-a-vue-3-vite-project-319g
#https://medium.com/@techsolutionstuff/how-to-install-tailwind-css-in-vue-3-1b59f062e2c7
#https://vueschool.io/articles/vuejs-tutorials/master-tailwindcss-4-for-vue/
#https://flowbite.com/docs/getting-started/vue/
#https://v2.tailwindcss.com/docs/guides/vue-3-vite
npm create vite@latest mes-frontend -- --template vue
cd mes-frontend
npm install
npm install -D tailwindcss @tailwindcss/vite @tailwindcss/cli
#npm install -D tailwindcss @tailwindcss/postcss postcss
#npx tailwindcss init -p