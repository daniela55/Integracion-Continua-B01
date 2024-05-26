import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({
    name: 'users'
})
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({
    type: 'datetime',
    default: () => 'CURRENT_TIMESTAMP',
  })
  createdAt: Date;
}
