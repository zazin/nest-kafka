import { Module } from '@nestjs/common';
import { ApiGatewayController } from './api-gateway.controller';
import { ApiGatewayService } from './api-gateway.service';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { ConfigModule } from '@nestjs/config';
import { ServerConfig } from '../../user/src/server-config';
import * as fs from 'fs';

@Module({
  imports: [
    ConfigModule.forRoot(),
    ClientsModule.register([
      {
        name: 'USER_SERVICE',
        transport: Transport.KAFKA,
        options: {
          client: {
            ssl: {
              rejectUnauthorized: false,
              passphrase: ServerConfig.KAFKA_PASSWORD,
              key: fs.readFileSync(ServerConfig.KAFKA_SSL_KEY, 'utf-8'),
              cert: fs.readFileSync(ServerConfig.KAFKA_SSL_CERT, 'utf-8'),
              ca: fs.readFileSync(ServerConfig.KAFKA_SSL_CA, 'utf-8'),
            },
            requestTimeout: 5000,
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
