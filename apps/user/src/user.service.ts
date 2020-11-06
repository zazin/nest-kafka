import { Injectable, Logger } from '@nestjs/common';

@Injectable()
export class UserService {
  async getUser(): Promise<string> {
    const date = new Date().toUTCString();
    Logger.log('user-success', date);
    return date;
  }
}
