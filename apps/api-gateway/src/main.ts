import { NestFactory } from '@nestjs/core';
import { ApiGatewayModule } from './api-gateway.module';
import { ServerConfig } from './server-config';

async function bootstrap() {
  const app = await NestFactory.create(ApiGatewayModule);
  await app.listen(ServerConfig.PORT);
}
bootstrap();
