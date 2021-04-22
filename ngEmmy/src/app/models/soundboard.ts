import { Category } from "./category";
import { SoundboardExpression } from "./soundboard-expression";
import { User } from "./user";

export class Soundboard {
  id: number;
  name: string;
  description: string;
  createDate: string;
  isPublic: boolean;
  isDefault: boolean;
  user: User;
  categories: Category[];
  soundboardExpressions: SoundboardExpression[];


  constructor(id?: number, name?: string, description?: string, createDate?: string, isPublic?: boolean, isDefault?: boolean, user?: User, categories?: Category[], soundboardExpressions?: SoundboardExpression[] ){
    this.id = id;
    this.name = name;
    this.description = description;
    this.createDate = createDate;
    this.isPublic = isPublic;
    this.isDefault = isDefault;
    this.user = user;
    this.categories = categories;
    this.soundboardExpressions = soundboardExpressions;
  }

}
