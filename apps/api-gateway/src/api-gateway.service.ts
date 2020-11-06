import { Inject, Injectable } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { map } from 'rxjs/operators';

@Injectable()
export class ApiGatewayService {
  constructor(@Inject('USER_SERVICE') private client: ClientProxy) {}

  getHello(): string {
    return 'Hello World!';
  }

  async getUser(): Promise<{ message: string; duration: number }> {
    const startTs = Date.now();
    const pattern = { cmd: 'user' };
    const payload = {};
    return this.client
      .send<string>(pattern, payload)
      .pipe(
        map((message: string) => ({ message, duration: Date.now() - startTs })),
      )
      .toPromise();
  }
}
