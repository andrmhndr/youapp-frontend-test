import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import { UpdateProfileDto } from './dto/update-profile.dto';
import { User } from './schemas/user.schema';

describe('AuthController', () => {
  let controller: AuthController;
  let authService: AuthService;

  const mockAuthService = {
    authCheck: jest.fn(),
    register: jest.fn(dto => {
      return {
        token: Date.now(),
        ...dto
      };
    }),
    login: jest.fn(dto => {
      return {
        token: Date.now(),
        ...dto
      };
    }),
    getProfile: jest.fn(profile => {
      return {
        ...profile
      };
    }),
    updateProfile: jest.fn((email, profile) => {
      return {
        email,
        ...profile
      };
    })
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthController],
      providers: [AuthService],
    })
      .overrideProvider(AuthService)
      .useValue(mockAuthService)
      .compile();

    controller = module.get<AuthController>(AuthController);
    authService = module.get<AuthService>(AuthService);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('authCheck', () => {
    it('should return a token', async () => {
      const result = { message: 'Authorized' };
      jest.spyOn(authService, 'authCheck').mockResolvedValue(result);

      expect(await controller.authCheck()).toEqual(result);
    });
  });

  describe('register', () => {
    it('should return a token', async () => {
      const registerDto: RegisterDto = {
        username: 'testingunit',
        email: 'testingunit@example.com',
        password: 'testing',
        image: null,
        gender: null,
        birthday: null,
        height: null,
        weight: null,
        interests: null
      };
      const result = { token: 'dummyToken' };
      jest.spyOn(authService, 'register').mockResolvedValue(result);

      expect(await controller.register(registerDto)).toEqual(result);
    });
  });

  describe('login', () => {
    it('should return a token', async () => {
      const loginDto: LoginDto = {
        email: 'gandrainsan@example.com',
        password: 'testtest',
      };

      const result = { token: 'dummyToken', username: 'andra' };
      jest.spyOn(authService, 'login').mockResolvedValue(result);

      expect(await controller.login(loginDto)).toEqual(result);
    });
  });

  describe('getProfile', () => {
    it('should return a user', async () => {
      const email = 'gandrainsan@example.com';
      const user: User = {
        username: 'andra',
        email: 'gandrainsan@example.com',
        password: 'testing',
        image: null,
        gender: null,
        birthday: null,
        height: null,
        weight: null,
        interests: null
      };

      jest.spyOn(authService, 'getProfile').mockResolvedValue(user);

      expect(await controller.getProfile(email)).toEqual(user);
    });
  });

  describe('updateProfile', () => {
    it('should return an updated user', async () => {
      const email = 'gandrainsan@example.com';
      const profile: UpdateProfileDto = {
        username: 'andra',
        image: null,
        gender: null,
        birthday: null,
        height: null,
        weight: null,
        interests: null
      };
      const user: User = {
        username: 'andra',
        email: 'gandrainsan@example.com',
        password: 'testing',
        image: null,
        gender: null,
        birthday: null,
        height: null,
        weight: null,
        interests: null
      };

      jest.spyOn(authService, 'updateProfile').mockResolvedValue(user);

      expect(await controller.updateProfile(email, profile)).toEqual(user);
    });
  });
});
