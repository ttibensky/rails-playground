FROM touch4it/puppeteer:19.7.3
COPY --chown=pptruser app /app
WORKDIR /app
RUN npm i && node node_modules/puppeteer/install.js
ENV PATH="${PATH}:/node_modules/.bin"
CMD [ "node", "index.js" ]
