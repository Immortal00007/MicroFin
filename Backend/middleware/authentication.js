const jwt=require('jsonwebtoken');
const { UnauthenticatedError } = require('../errors');


const authenticateuser=(req,res,next)=>{
    const authheader=req.headers.authorization;
    if(!authheader || !authheader.startsWith('Bearer')){
        throw new UnauthenticatedError('Authentication failed');
    }
    const token =authheader.split(' ')[1];
    try{
        const decoded=jwt.verify(token,process.env.JWT_KEY);
        req.user={userId:decoded.userId};
        next()
    }catch{
        throw new UnauthenticatedError('Authentication failed');
    }
}

module.exports=authenticateuser;