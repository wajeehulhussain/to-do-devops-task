# Front-end API
This is a single page application that uses the APIs exposed by the backend service

## Dev
To run it locally use the following command:
```
npm install
npm start
```

after this the API endpoint is listening on port 3000


## Production
To compile the application execute the following commands

```
npm install
npm run build
```

The `build` subfolder will contains the artifacts that have to be deployed on the [Content delivery network](https://en.wikipedia.org/wiki/Content_delivery_network)


The following environment variables can be used to customize the process when executed in production:

* REACT_APP_API: the url to connect in order to fetch data

You can either update the .env.production file before you run the `npm run build` command or use a command like this `REACT_APP_API="http://[add your url here]/api/tasks" npm start`