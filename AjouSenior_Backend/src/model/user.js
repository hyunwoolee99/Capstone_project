import mongoose from 'mongoose';
const {Schema} = mongoose;

const userSchema = new Schema({
    profile_nickname :{
        type : String
    },
    account_email :{
        type : String
    },
    gender :{
        type : String
    },
    age_range : {
        type: String
    },
    seniorcenter : {
        type: String
    },
    birthday : {
        type : Date
    }
});

export default mongoose.model('User', userSchema,"User");
