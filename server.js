require('dotenv').config();
const express = require("express");
const cors = require("cors");

const app = express();

const corsOptions ={
  origin:'http://localhost:3000', 
  credentials: true,
  optionSuccessStatus: 200
}

app.use(cors(corsOptions));

app.use(express.json());
app.use(express.urlencoded({ extended: true })); 

app.get("/", (req, res) => {
  res.json({ message: "HEALTHIS API" });
});

require("./app/routes/vacinas.routes.js")(app);

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});
