const { Timestamp } = require('bson')
const mongoose = require('mongoose')
const Schema = mongoose.Schema

const streamerSchema = new Schema({
        username:{
            type: String
        },
        email: {
            type: String
        },
        password:{
            type: String
        }
},{timestamp:true})

const Streamer = mongoose.model('Streamer',streamerSchema)
module.exports = Streamer