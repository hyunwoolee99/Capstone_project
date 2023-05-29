import mongoose from 'mongoose';
const {Schema} = mongoose;

const communitySchema = new Schema({
    title :{
        type : String
    },
    content :{
        type : String
    },
    writer :{
        type : String
    },
    comment : {
        type: String
    },
    date : {
        type : Date
    }
});

export default mongoose.model('Community', communitySchema,"Community");
