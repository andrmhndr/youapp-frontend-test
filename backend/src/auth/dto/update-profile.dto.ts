
export class UpdateProfileDto {
    readonly username: string;
    readonly image: string[];
    readonly gender: string;
    readonly birthday: Date;
    readonly height: number;
    readonly weight: number;
    readonly interests: string[];
}