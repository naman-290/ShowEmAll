const Streamer = require('../models/Streamer')

const index = (req,res,next) => {
    Streamer.find()
    .then(response => {
        res.json({
            response
        })
    })
    .catch(error => (
        res.json({
            message:"An error has occured!:1"
        })
    ))
}

const show = (req,res,next) => {
    let streamerID = req.body.streamerID
    Streamer.findById(streamerID)
    .then(response => {
        res.json({
            response
        })
    })
    .catch(error =>(
        res.json({
            message: "An error has Occured!:2"
        })
    ))
}

const store = (req,res,next) =>{
    let streamer = new Streamer({
       username: req.body.username,
       email: req.body.email,
       password: req.body.password
    })
    streamer.save()
    .then(response => {
        res.json({
            message:"Streamer data save successfully!"
        })
    })
    .catch(error =>{
        res.json({
            message:"An error has Occured!:3"
        })
    })
}

const update = (req,res,next) =>{
    let streamerID = req.body.streamerID

    let updatedData = {
        username: req.body.username,
        email: req.body.email,
        password: req.body.password
    }

    Streamer.findByIdAndUpdate(streamerID,{$set: updatedData})
    .then(()=>{
        res.json({
            message: 'Streamer data updated success'
        })
    })
    .catch(error =>{
        res.json({
            message: "An error has occured!:4"
        })
    })
}

const destroy = (req,res,next) =>{
     let streamerID = req.body.streamerID
     Streamer.findByIdAndRemove(streamerID)
     .then(() =>{
         res.json({
            message: "Streamer data deleted success"
         })
     })
     .catch(error => {
         res.json({
            message: "An error has occured!:5"
         })
     })
}

module.exports = {
    index,show,update,destroy,store
}