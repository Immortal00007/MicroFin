require("dotenv").config();
require('express-async-errors');
const express = require("express");
const authrouter=require('./routes/auth');
const connectDB = require("./db/db");
const cors=require('cors');
const app = express();

// middleware
const authenticateuser=require('./middleware/authentication');

// error handlers
const notFoundMiddleware = require('./middleware/not-found');
const errorHandlerMiddleware = require('./middleware/error-handler');


app.use(express.json());

app.use(cors());



// Routers
app.use('/api/v1/auth',authrouter);


// errorshandlers called
app.use(notFoundMiddleware);
app.use(errorHandlerMiddleware);


const port=process.env.PORT||3000;

const start = async () => {
  try {
    await connectDB(process.env.connectionstring);
    app.listen(port, () =>
      console.log(`app listening on port http://localhost:${port}/`)
    );
  } catch (error) {
    console.log(error);
  }
};

start();