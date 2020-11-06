import { Inject, Injectable } from '@nestjs/common';
import { ClientKafka } from '@nestjs/microservices';
import { map } from 'rxjs/operators';

@Injectable()
export class ApiGatewayService {
  constructor(@Inject('USER_SERVICE') private client: ClientKafka) {
    this.onModuleInit();
  }

  onModuleInit() {
    this.client.subscribeToResponseOf('user.all');
  }

  getHello(): string {
    return 'Hello World!';
  }

  async getUser(): Promise<{ message: string; duration: number }> {
    const startTs = Date.now();
    return this.client
      .send<string>('user.all', {})
      .pipe(
        map((message: string) => ({ message, duration: Date.now() - startTs })),
      )
      .toPromise();
  }
}
