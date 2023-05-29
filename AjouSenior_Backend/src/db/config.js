import mongoose from "mongoose"
import dotenv from 'dotenv';

dotenv.config();
const uri = process.env.MONGO_URI

const connect = () =>{
    mongoose.connect(uri,{
        dbName : "AjouSenior"
    })
    .then(() => {
        console.log('MongoDB conected')
    }
        )
    .catch((err) => {
        console.log(err);
    });
  
};

mongoose.connection.on('error', (error)=>{
    console.log('mongodb connect error', error);
});
mongoose.connection.on('disconnected',()=>{
    console.log('mongodb id disconnected. Tying to connect again');
    connect();
});

export default connect
