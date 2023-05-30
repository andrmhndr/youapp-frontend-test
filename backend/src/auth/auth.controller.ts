import { Body, Controller, Get, Param, Post, Put, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import { User } from './schemas/user.schema';
import { UpdateProfileDto } from './dto/update-profile.dto';
import { AuthGuard } from '@nestjs/passport';

@Controller('api')
export class AuthController {
    constructor( private authService: AuthService){}

    @Get('/authCheck')
    @UseGuards(AuthGuard())
    authCheck(): Promise<{ message: string}>{
        return this.authService.authCheck();
    }


    @Post('/register')
    register(
        @Body()
        registerDto: RegisterDto
    ): Promise<{ token: string }> {
        return this.authService.register(registerDto);
    }

    @Post('/login')
    login(
        @Body()
        loginDto: LoginDto
    ): Promise<{ token: string }>{
        return this.authService.login(loginDto);
    }

    @Get('/getProfile/:email')
    @UseGuards(AuthGuard())
    getProfile(
        @Param('email')
        email:string
    ): Promise<User>{
        return this.authService.getProfile(email);
    }

    @Put('/updateProfile/:email')
    @UseGuards(AuthGuard())
    updateProfile(
        @Param('email')
        email:string,
        @Body()
        profile: UpdateProfileDto,
    ): Promise<User> {
        return this.authService.updateProfile(email,profile);
    }
}
