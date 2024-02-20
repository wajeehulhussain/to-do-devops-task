# Back-end API
This is a simple nodejs server that connects to mongodb

## Dev
To run it locally use the following command:
```
npm install
npm start
```

after this the API endpoint is listeing on port 3000

## Production
The following environment variables can be used to customize the process when executed in production:

* PORT: the [listening port](http://expressjs.com/en/5x/api.html#app.listen)
* MONGO_URL: [connection string](https://www.mongodb.com/docs/manual/reference/connection-string/) to the mongodb
