import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PhotoModule } from './photo/photo.module';
import { databaseProviders } from './providers/database.provider';

@Module({
  imports: [PhotoModule],
  controllers: [AppController],
  providers: [AppService, ],
})
export class AppModule {}
