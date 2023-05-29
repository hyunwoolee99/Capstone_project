import mongoose from 'mongoose';
const {Schema} = mongoose;

const talentdonationhopeSchema = new Schema({
    donationId : {
        type : Object
    },
    userId : {
        type : Object
    },
    status : {
        type : Boolean
    }
});

export default mongoose.model('Talentdonationhope', talentdonationhopeSchema,"Talentdonationhope");
