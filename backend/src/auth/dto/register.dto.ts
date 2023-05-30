import { IsEmail, IsDate, IsNotEmpty, IsNumber, IsString, MinLength, IsArray } from 'class-validator'

export class RegisterDto {
    @IsNotEmpty()
    @IsString()
    readonly username:string;
    
    @IsNotEmpty()
    @IsEmail({},{ message: "Please enter correct email" })
    readonly email:string;
    
    @IsNotEmpty()
    @IsString()
    @MinLength(6)
    readonly password:string;
    
    @IsString()
    readonly image: string;

    @IsString()
    readonly gender: string;

    @IsDate()
    readonly birthday: Date;

    @IsNumber()
    readonly height: number;

    @IsNumber()
    readonly weight: number;

    @IsArray()
    readonly interests: string[]
}