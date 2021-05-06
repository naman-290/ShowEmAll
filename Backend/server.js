const express = require('express')
const mongoose = require('mongoose')
const morgan = require('morgan')
const bodyParser = require('body-parser')
const StreamerRoute = require('./routes/streamer')
const AuthRoute = require('./routes/auth')

mongoose.connect('mongodb://localhost:27017/testdb',{useNewUrlParser: true,useUnifiedTopology: true})

const db = mongoose.connection
db.on('error',(err) => {
    console.log(err)

})

db.once('open',()=> {
    console.log("Db Connection successs")
})

const app = express()
app.use(morgan('dev'))
app.use(bodyParser.urlencoded({extended: true}))
app.use(bodyParser.json())

const port = process.env.PORT || 3000

app.listen(port,()=>{
    console.log('Server is running '+port)
})

app.use('/api/streamer',StreamerRoute)
app.use('/api',AuthRoute)