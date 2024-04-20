const Userschema=require('../models/Userschema');
const {StatusCodes}=require('http-status-codes');
const {BadRequestError,UnauthenticatedError}=require('../errors')

const register=async(req,res)=>{
    const user=await Userschema.create({...req.body});
    const token=user.createjwt();
    res.status(StatusCodes.OK).json({token});
}

const login=async(req,res)=>{
    const {email,password}=req.body;
    if(!email || !password){
        throw new BadRequestError('Please Provide email and password');
    }
    const user=await Userschema.findOne({email});

    if(!user){
        throw new UnauthenticatedError('Invalid Credentials');
    }
    const checkpass=await user.comparepasswords(password);

    if(!checkpass){
        throw new UnauthenticatedError('Invalid Credentials')
    }
    const token=user.createjwt();
    res.status(StatusCodes.OK).json({token});
}

module.exports={register,login};