import * as env from 'env-var';
import { config } from 'dotenv';

config();

export class ServerConfig {
  public static readonly PORT: number = env
    .get('PORT')
    .required()
    .asPortNumber();

  public static readonly KAFKA_PASSWORD: string = env
    .get('KAFKA_PASSWORD')
    .required()
    .asString();

  public static readonly KAFKA_SSL_KEY: string = env
    .get('KAFKA_SSL_KEY')
    .required()
    .asString();

  public static readonly KAFKA_SSL_CERT: string = env
    .get('KAFKA_SSL_CERT')
    .required()
    .asString();

  public static readonly KAFKA_SSL_CA: string = env
    .get('KAFKA_SSL_CA')
    .required()
    .asString();
}
