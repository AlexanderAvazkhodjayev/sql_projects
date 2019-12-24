var express = require('express');
var mysql = require('mysql');
var app = express();
var bodyParser = require("body-parser");
app.use(express.static(__dirname + "/public"));

app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({extended: true}))
 
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',     // your root username
  database : 'join_us',   // the name of your db
  password : 'Florida7'
});

app.post("/register", function(req,res){
    var person = {
        email: req.body.email
    };

    connection.query('INSERT INTO users SET ?', person, function(err,result){
        if (err) throw err;
        res.redirect("/");
    });
});

app.get("/", function(req,res){
    //Find count of users in DB
    var q = "SELECT COUNT(*) AS count FROM users";
    connection.query(q,function(err,results){
    if (err) throw err;
    var count = results[0].count;
    //res.send("We have " + count + " users in our db")
    res.render("home", {data: count});
    });
});

app.get("/joke", function(req,res){
    var joke = "asdasfafsdfdsfds";
    res.send(joke);
});

app.get("/random_num", function(req, res){
    var num = Math.floor((Math.random() * 10) + 1);
    res.send("Your lucky number is " + num);
});

app.listen(8080, function(){
    console.log("Server running on 8080!");
});

