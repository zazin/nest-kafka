import { Module } from '@nestjs/common';
import { ApiGatewayController } from './api-gateway.controller';
import { ApiGatewayService } from './api-gateway.service';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot(),
    ClientsModule.register([
      { name: 'USER_SERVICE', transport: Transport.TCP },
    ]),
  ],
  controllers: [ApiGatewayController],
  providers: [ApiGatewayService],
})
export class ApiGatewayModule {}
