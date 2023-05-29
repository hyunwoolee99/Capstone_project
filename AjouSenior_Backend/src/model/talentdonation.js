import mongoose from 'mongoose';
const {Schema} = mongoose;

const talentdonationSchema = new Schema({
    seniorcenter :{
        type : String
    },
    writer :{
        type : String
    },
    date :{
        type : Date
    },
    content : {
        type: String
    },
    maxpeople : {
        type : Number
    },
    currentpeople : {
        type : Number
    },
    latitude : {
        type : String
    },
    longitude : {
        type : String
    }
});

export default mongoose.model('Talentdonation', talentdonationSchema,"Talentdonation");
