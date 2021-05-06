const express = require('express')
const router =  express.Router()
const StreamerController = require('../controllers/StreamerController')


router.get('/',StreamerController.index)
router.post('/show',StreamerController.show)
router.post('/store',StreamerController.store)
router.post('/update',StreamerController.update)
router.post('/delete',StreamerController.destroy)

module.exports = router
