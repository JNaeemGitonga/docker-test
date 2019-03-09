
FROM node:11.3.0
RUN mkdir -p /app
WORKDIR /app
COPY . /app
RUN npm i
ENTRYPOINT [ "npm" ]
CMD ["start"]
