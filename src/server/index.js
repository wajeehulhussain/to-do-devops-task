const tasks = require("./routes/tasks");
const livez = require("./routes/livez");
const connection = require("./db");
const cors = require("cors");
const express = require("express");
const app = express();

connection();

app.use(express.json());
app.use(cors());

app.use("/api/tasks", tasks);
app.use("/livez", livez);

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Listening on port ${port}...`));
