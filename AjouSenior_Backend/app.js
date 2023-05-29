import express from "express"
import connect from "./src/db/config.js";
import router from "./src/routes/index.js";

const app = express();
connect()

app.use(express.static('public'));
app.use(express.urlencoded({extended: true}));
app.use(express.json());

// app.get('/', (req, res) => {
//   res.send('hello node!!');
// })
app.use('/', router)
app.listen(4000, () => console.log('4000번 포트에서 대기중'));
