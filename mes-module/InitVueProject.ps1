#### FRONT END #########

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
#https://reintech.io/blog/using-the-vuejs-cli-to-generate-components
npm create vite@latest mes-frontend -- --template vue
cd mes-frontend
npm install
npm install -D tailwindcss @tailwindcss/vite @tailwindcss/cli
#npm install -D tailwindcss @tailwindcss/postcss postcss
#npx tailwindcss init -p


## https://medevel.com/22-vue-dashboards/
#USE THIS: https://github.com/epicmaxco/vuestic-admin
#https://github.com/iqonicdesignofficial/hope-ui-vue-dashboard?tab=readme-ov-file#method-2-using-npm
#https://github.com/creativetimofficial/vue-notus

#### BACK END #########
cd C:\GithubProject\mes-module
mkdir mes-backend
cd mes-backend
npm init -y
npm install express body-parser cors pg