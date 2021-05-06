const User = require('../models/User')
const jwt = require('jsonwebtoken')

const register = (req,res,next) => {
   
    let user = new User({
        username: req.body.username,
        email: req.body.email,
        password: req.body.password
    })
    user.save()
    .then(user => {
        res.json({
        message: 'User added success'
        })
    })
    .catch(error => {
        res.json({
            messsage:'An error occures!'
        })
    })

     
}

const login = (req,res,next) =>{

    
        var email = req.body.email
        var password = req.body.password
        
                
    
        User.findOne({$or: [{username:email},{email:email}]})
        .then(user => {
            if(user){
                if(password == user.password)
                {
                   res.json({
                       'email': user.email,
                       'password': user.password,
                       'status': 'true'
                   })
                }
                else{
                    res.json({
                        message: "Password do not match",
                        'status': 'false'
                    })
                }
           }else{
               res.json({
                   message: "No user Found!",
                   'status': 'false'
               })
           }
        })
   
    
}

module.exports ={
    register,login
}