import { NestFactory } from '@nestjs/core';
import { UserModule } from './user.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';
import { ServerConfig } from './server-config';

async function bootstrap() {
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(
    UserModule,
    {
      transport: Transport.KAFKA,
      options: {
        client: {
          ssl: ServerConfig.KAFKA_SSL,
          requestTimeout: 5000,
          sasl: {
            mechanism: 'plain',
            username: ServerConfig.KAFKA_USER,
            password: ServerConfig.KAFKA_PASSWORD,
          },
          clientId: ServerConfig.KAFKA_CLIENT_ID,
          brokers: [`${ServerConfig.KAFKA_HOST}:${ServerConfig.KAFKA_PORT}`],
        },
        consumer: {
          groupId: ServerConfig.KAFKA_GROUP_ID,
        },
      },
    },
  );
  await app.listen(() => console.log('Microservice user is listening'));
}

bootstrap();
