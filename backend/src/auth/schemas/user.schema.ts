import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";

@Schema({
    timestamps: true
})

export class User{
    @Prop({ unique: [true, 'Duplicate email entered' ]})
    email: string
    @Prop()
    username: string
    @Prop()
    password: string
    @Prop()
    image: string
    @Prop()
    gender: string
    @Prop()
    birthday: Date
    @Prop()
    height: number
    @Prop()
    weight: number
    @Prop()
    interests: string[]
}

export const UserSchema = SchemaFactory.createForClass(User);