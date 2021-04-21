import { Expression } from "@angular/compiler";
import { Soundboard } from "./soundboard";

export class User {

  id: number;
  firstName: string;
  lastName: string;
  username: string;
  password: string;
  email: string;
  role: string;
  isRestricted: boolean;
  isActive: boolean;
  soundboards: Soundboard[];
  expressions: Expression [];

  constructor(id?: number,firstName?: string,lastName?: string,username?: string, password?: string, email?: string,role?: string, isRestricted?: boolean, isActive?: boolean, soundboards?: Soundboard [], expressions?: Expression[]){
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.username = username;
    this.password = password;
    this.email = email;
    this.role = role;
    this.isRestricted = isRestricted;
    this.isActive = isActive;
    this.soundboards = soundboards;
    this.expressions = expressions;
  }
}
