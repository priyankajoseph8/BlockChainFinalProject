const express = require("express");
const path = require("path");

const app = express();

app.use(express.static('public'));

app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname + "/index.html"));
})

app.get("/admin", (req, res) => {
    res.sendFile(path.join(__dirname + "/index_OLD.html"));
})
app.get("/about", (req, res) => {
    res.sendFile(path.join(__dirname + "/aboutUs.html"));
})

app.get("/signup", (req, res) => {
    res.sendFile(path.join(__dirname + "/signup.html"));
})

app.get("/BasketballBetting", (req, res) => {
    res.sendFile(path.join(__dirname + "/BasketballBetting.html"));
})


// serving the index.html file 

const server = app.listen(3000);
const portNumber = server.address().port;
console.log(`port: ${portNumber}`);
// can see the port number in terminal - you can dictate the port number