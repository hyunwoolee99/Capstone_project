import { Router } from 'express';
import Community from '../model/community.js';
import Talentdonation from "../model/talentdonation.js"
import User from "../model/user.js"
import SeniorCenter from "../model/seniorcenter.js"
import Talentdonationhope from "../model/talentdonationhope.js"
const router = Router();
var today = new Date()
router.post('/user/signup',function(req,res){
    const profile_nickname = req.body.profile_nickname;
    const account_email = req.body.account_email;
    const gender = req.body.gender;
    const age_range = req.body.age_range
    const seniorcenter = req.body.seniorcenter
    const birthday = req.body.birthday
    const user = new User({
        profile_nickname : profile_nickname,
        account_email : account_email,
        gender : gender,
        age_range : age_range,
        seniorcenter: seniorcenter,
        birthday : birthday
    });
    user.save().then(function(obj){
        res.json({
            type : true,
            data : obj
        })
    })
})

router.post('/community/upload', function(req, res){
    const title = req.body.title;
    const content = req.body.content;
    const writer = req.body.writer;
    const comment = req.body.comment
    const date = req.body.date
    const community = new Community({
        title : title,
        content : content,
        writer : writer,
        comment : comment,
        date : date
    });
    community.save().then(() => 
        console.log('Saved successfully'),
        res.json(200)
        );
});
router.get('/community/readall',function(req,res){
    Community.find().then(function(obj){
        console.log(obj)
        res.json({
            type : true,
            data : obj  
          })
    })
})
router.post('/talentdonation/upload', function(req, res){
    const seniorcenter = req.body.seniorcenter
    const findSeniorcenter = {
        BIZPLC_NM : seniorcenter
    }
    console.log(req.body.seniorcenter)
    SeniorCenter.findOne(findSeniorcenter).then(function(obj){
        if (obj == null) {
            res.json({
                type : true,
                data : "경로당의 위치를 확인할 수 없습니다"  
              })
        }
        else{
            const writer = req.body.writer;
            const date = req.body.date;
            const content = req.body.content
            const maxpeople = req.body.maxpeople
            const latitude = obj.REFINE_WGS84_LAT
            const longitude = obj.REFINE_WGS84_LOGT
            const talentdonation = new Talentdonation({
                seniorcenter : seniorcenter,
                writer : writer,
                date : date,
                content : content,
                maxpeople : maxpeople,
                currentpeople : 0,
                latitude : latitude,
                longitude : longitude,
            });
            talentdonation.save().then(() => 
                console.log('Saved successfully'),
                res.json(200)
                );
            }
        })
});
router.get('/talentdonation/readall',function(req,res){
    Talentdonation.find().then(function(obj){
        const filterData = obj.filter((item)=> {
            const itemDate = new Date(item.date)
            return itemDate > today
        })
        res.json({
            type : true,
            data : filterData
        })
    })
})
router.post('/talentdonation/findone',function(req,res){
    const donationid = req.body.donationid
    const findDonation = {
        _id : donationid
    }
    Talentdonation.findOne(findDonation).then(function(obj){
        res.json({
            type : true,
            data : obj
        })
    })
})
router.post('/talentdonation/hope', function(req,res){  //프론트 단에서 maxpeople과 currentpeople 비교 작업 필요
    const donationid = req.body.donationid
    const userid = req.body.userid
    const currentpeople = parseInt(req.body.currentpeople)
    const talentdonationhope = new Talentdonationhope({
        donationId : donationid,
        userId : userid
    })
    Talentdonation.updateOne({_id:donationid},{$set : {currentpeople:currentpeople+1}}).exec()
    talentdonationhope.save().then(() => 
        console.log('Saved successfully'),
        res.json(200)
    );
})
router.get('/seniorcenter/readall',function(req,res){
    SeniorCenter.find().then(function(obj){
        console.log(obj)
        res.json({
          type : true,
          data : obj  
        })
    })
})
router.post('/seniorcenter/findseniorcenter',function(req,res){
    const findname = req.body.findname
    SeniorCenter.find({"BIZPLC_NM":{"$regex":`${findname}`}}).then(function(obj){
        console.log(obj)
        res.json({
            type : true,
            data : obj
        })
    })
})

router.post('/junior/findtalentdonationhope',function(req,res){
    const userId = req.body.userId
    const findTalentdonationhpoe = {
        userId : userId
    }
    
    Talentdonationhope.find(findTalentdonationhpoe).then(function(obj){
        const results = []
        let count = 0
        obj.forEach((element, index) =>{
            Talentdonation.find({_id : element.donationId}).then(function(result){
                results[index] = result
                count++
                if (count === obj.length){
                    res.json({
                        type :true,
                        data : results
                    })
                }
            })
        })
            
        })
    })

router.post('/senior/findtalentdonationhope',function(req,res){
    const donationid = req.body.donationid
    const findDonation = {
        donationId : donationid
    }
    Talentdonationhope.find(findDonation).then(function(obj){
        const results = []
        let count = 0
        obj.forEach((element, index) =>{
            User.find({_id : element.userId}).then(function(result){
                results[index] = result
                count++
                if (count === obj.length){
                    res.json({
                        type :true,
                        data : results
                    })
                }
            })
        })
    })
})
router.post('/senior/mytalentdonation', function(req, res){
    const username = req.body.username
    const finduser = {
        writer : username
    }
    Talentdonation.find(finduser).then(function(obj){
        const filterData = obj.filter((item)=> {
            const itemDate = new Date(item.date)
            return itemDate > today
        })
        res.json({
            type : true,
            data : filterData
        })
    })
})
    
router.post('/senior/mylastdatedonation', function(req,res){
    const today = new Date();
    const username = req.body.username
    const finduser = {
        writer : username
    }
    Talentdonation.find(finduser).then(function(obj){
        const filterData = obj.filter((item)=> {
            const itemDate = new Date(item.date)
            return itemDate < today
        })
        res.json({
            type : true,
            data : filterData
        })
    })
})

router.post('/senior/talentdonationconfirm', function(req,res){
    const donationid = req.body.donationid
    const userid = req.body.userid
    const findtalentdonationhope = {
        donationId : donationid,
        userId : userid,
    }
    Talentdonationhope.updateOne(findtalentdonationhope, { $set: { status: true } }, { upsert: true }).then(function(result){
        res.json({
            type : true,
            data : result
        })
    })
})

router.post('/junior/confirmfindtalentdonationhope',function(req,res){
    const userId = req.body.userId
    const findTalentdonationhpoe = {
        userId : userId
    }
    
    Talentdonationhope.find(findTalentdonationhpoe).then(function(obj){
        const results = []
        let count = 0
        obj.forEach((element, index) =>{
            if(element.status == true){
                Talentdonation.find({_id : element.donationId}).then(function(result){
                    results.push(result)
                    count++
                    if (count === obj.length){
                        res.json({
                            type :true,
                            data : results
                        })
                    }
                })
            }
            else{
                count++
                if (count === obj.length){
                    res.json({
                        type :true,
                        data : results
                    })
                }
            }
        })
            
        })
    })
export default router