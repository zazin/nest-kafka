import { Module } from '@nestjs/common';
import { ApiGatewayController } from './api-gateway.controller';
import { ApiGatewayService } from './api-gateway.service';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { ConfigModule } from '@nestjs/config';
import { ServerConfig } from '../../user/src/server-config';

@Module({
  imports: [
    ConfigModule.forRoot(),
    ClientsModule.register([
      {
        name: 'USER_SERVICE',
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
    ]),
  ],
  controllers: [ApiGatewayController],
  providers: [ApiGatewayService],
})
export class ApiGatewayModule {}
