import { Injectable, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from './schemas/user.schema';
import * as bcrypt from 'bcryptjs'
import { JwtService } from '@nestjs/jwt';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import { UpdateProfileDto } from './dto/update-profile.dto';

@Injectable()
export class AuthService {
    constructor(
        @InjectModel(User.name)
        private userModel: Model<User>,
        private jwtService: JwtService
    ){}

    async authCheck(): Promise<{ message: string }> {
        return { message: 'Authorized' };
    }

    async register(registerDto: RegisterDto): Promise<{ token:string }>{
        const { username, email, password } = registerDto

        const hashedPassword = await bcrypt.hash(password, 10)

        const user = await this.userModel.create({
            username, 
            email, 
            password: hashedPassword,
            image: null,
            gender: null,
            birthday: null,
            height: null,
            weight: null,
            interests: [],
        })

        const token = this.jwtService.sign({ id: user._id })

        return { token }
    }

    async login(loginDto: LoginDto): Promise<{ token: string, username: string }> {
        const { email, password } = loginDto;

        const user = await this.userModel.findOne({ email })

        if(!user){
            throw new UnauthorizedException('Invalid email')
        }

        const isPasswordMatched = await bcrypt.compare(password, user.password)

        if(!isPasswordMatched){
            throw new UnauthorizedException('Invalid password')
        }

        const token = this.jwtService.sign({ id: user._id })

        return { token, username: user.username }
        
    }

    async getProfile(email: string): Promise<User> {
        const profile = await this.userModel.findOne({ email })

        if(!profile) {
            throw new NotFoundException('Profile not found')
        }

        return profile;
    }

    async updateProfile(email: string, profile: UpdateProfileDto): Promise<User> {
        return await this.userModel.findOneAndUpdate({ email }, profile, {
            new: true,
            runValidators: true,
        });
    }
}
