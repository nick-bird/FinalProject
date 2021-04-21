import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  constructor(
    private soundboardService: SoundboardService,
    private expressionService: ExpressionService
  ) { }

  ngOnInit(): void {
  this.reload();
  }

soundboards: Soundboard[] = [];
expressions: Expression[] = [];
selectedSoundboard: Soundboard = null;
selectedExpression: Expression = null;
newSoundboard: Soundboard = null;
newExpression: Expression = null;
editSoundboard: Soundboard = null;
editExpression: Expression = null;

reload() {
  this.soundboardService.index().subscribe(
    data => {
      this.soundboards = data;
    },
    err => {
      console.log('Error loading soundboards: ' + err);
    }
  );
}
displaySoundboard(soundboard: Soundboard): void {
  this.selectedSoundboard = soundboard;
}

displayExpression(expression: Expression): void {
  this.selectedExpression = expression;
}

displaySoundboards(): void {
  this.selectedSoundboard = null;
  this.selectedExpression = null;
}

addSoundboard(): void {
  console.log(this.newSoundboard);
  this.soundboardService.create(this.newSoundboard).subscribe(
    data => {
      this.displaySoundboard(this.newSoundboard);
    },
    err => {
      console.log('Error creating todo: ' + err)
    }
  );

  addExpression(): void {
    console.log(this.newExpression);
    this.expressionService.create(this.newExpression).subscribe(
      data => {
        this.displayExpression(this.newExpression);
      },
      err => {
        console.log('Error creating expression: ' + err)
      }
    );

    setEditExpression(): void {
      this.editExpression = Object.assign({}, this.selected);
    }
    setEditSoundboard(): void {
      this.editSoundboard = Object.assign({}, this.selected);
    }


}
