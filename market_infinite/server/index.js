// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");

// IMPORTS FROM FILES
const authRouter=require("./routes/auth");
const adminRouter = require("./routes/admin");

// INIT
const PORT = 3000;
const app=express();
const DB = "mongodb+srv://naman_dwivedi:Nmndwdi10011001@cluster0.mbozqmm.mongodb.net/?retryWrites=true&w=majority";

// MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

// CONNECTIONS
mongoose.connect(DB).then(()=>{
    console.log("Connection Successful");
}).catch((e)=>{
    console.log(e);
});

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected at port ${PORT}`);
});