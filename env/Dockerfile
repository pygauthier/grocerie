FROM node:14.21.3 as build
COPY /env/entrypoint.sh /

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH
COPY package.json /usr/src/app/package.json
RUN yarn install --silent
COPY . /usr/src/app

ENTRYPOINT ["/entrypoint.sh"]
CMD ["wait"]
