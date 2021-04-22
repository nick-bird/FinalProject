import { Image } from "./image";
import { User } from "./user";

export class Expression {

  id: number;
  name: string;
  phrase: string;
  image: Image;
  user: User;


  constructor(id?: number, name?: string, phrase?: string, image?: Image, user?: User){
      this.id = id;
      this.name = name;
      this.phrase = phrase;
      this.image = image;
      this.user = user;
  }
}
