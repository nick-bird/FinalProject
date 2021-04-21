import { Image } from "./image";
import { User } from "./user";

export class Expression {
  id: number;
  name: string;
  pharse: string;
  image: Image;
  user: User;


  constructor(id: number,name: string, pharse: string, image: string, user: User){
      this.id = id;
      this.name = name;
      this.pharse = pharse;
  }
}
