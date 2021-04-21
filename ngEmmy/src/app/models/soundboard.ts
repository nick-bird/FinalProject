export class Soundboard {
  id: number;
  name: string;
  description: string;
  createDate: string;
  isPublic: boolean;
  isDefault: boolean;

  constructor(id: number, name: string, description: string, createDate: string, isPublic: boolean, isDefault: boolean ){

    this.id = id;
    this.name = name;
    this.description = description;
    this.createDate = createDate;
    this.isPublic = isPublic;
    this.isDefault = isDefault;
  }

}
