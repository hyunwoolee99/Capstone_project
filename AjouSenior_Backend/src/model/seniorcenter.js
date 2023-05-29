import mongoose from 'mongoose';
const {Schema} = mongoose;

const seniorcenterSchema = new Schema({
    _id :{
        type : String
    },
    SIGUN_NM :{ //소재지 도시
        type : String
    },
    BIZPLC_NM :{    //경로당 이름
        type : String
    },
    LICENSG_DE : {  //인허가 날짜
        type: String
    },
    BSN_STATE_NM : {    //현재 운영여부
        type: String
    },
    ENTRNC_FNOP : {    //입소 정원
        type: String
    },
    REFINE_ROADNM_ADDR : {    //경로당 도로명 주소
        type: String
    },
    REFINE_LOTNO_ADDR : {    //경로당 주소
        type: String
    },
    REFINE_ZIPNO : {    //경로당 우편번호
        type: String
    },
    REFINE_WGS84_LAT : {    //경로당 위도
        type: String
    },
    REFINE_WGS84_LOGT : {    //경로당 경도
        type: String
    }
});

export default mongoose.model('SeniorCenter', seniorcenterSchema,"SeniorCenter");
