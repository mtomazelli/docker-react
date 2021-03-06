# Primeira parte serve pra construir a parte do npm e gerar todo o build do projeto
FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

# Na segunda parte vou configurar o servidor nginx pra rodar meu projeto em produção e pra isso vou usar outra imagem
FROM nginx
# Avisa o elasticbeanstalk que eu quero mapear a porta 80 pro tráfego de entrada do meu container (só serve pro beanstalk mesmo...)
EXPOSE 80
# Estou copiando alguma coisa da fase 'builder' (da pasta build pra uma pasta especifica do nginx) -> Eu usava o AS BUILDER pra identificar a primera parte do arquivo mas tive de retirar pq a amazon nao entendia
COPY --from=0 /app/build /usr/share/nginx/html
#nginx ja comeca automaticamente entao nao preciso rodar nenhum comando
