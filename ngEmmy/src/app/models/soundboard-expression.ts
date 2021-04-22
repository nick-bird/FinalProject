import { Expression } from "./expression";
import { Soundboard } from "./soundboard";

export class SoundboardExpression {

id : number;
positionId : number;
soundboard : Soundboard;
expression : Expression;

constructor(
  id?: number,
  positionId?: number,
  soundboard?: Soundboard,
  expression?: Expression,

){
  this.id = id;
 this.positionId = positionId;
 this.soundboard = soundboard;
 this.expression = expression;
}
}
