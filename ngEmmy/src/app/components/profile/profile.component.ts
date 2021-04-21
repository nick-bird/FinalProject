import { Expression } from '@angular/compiler';
import { Component, OnInit } from '@angular/core';
import { Soundboard } from 'src/app/models/soundboard';
import { ExpressionService } from 'src/app/services/expression.service';
import { SoundboardService } from 'src/app/services/soundboard.service';

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
}

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
  }

    setEditExpression(): void {
      this.editExpression = Object.assign({}, this.selectedExpression);
    }
    setEditSoundboard(): void {
      this.editSoundboard = Object.assign({}, this.selectedSoundboard);
    }
    updateSoundboard(editedSoundboard: SoundboardService, displaySoundboard = true): void {
      this.soundboardService.update(editedSoundboard).subscribe(
        data => {
          this.reload();
          if(displaySoundboard){
            this.selectedSoundboard = editedSoundboard;
          }
           this.editSoundboard = null;
        },
        err => {
          console.log('Error updating soundboard: ' + err);
        }
      );
    }
      updateExpression(editedExpresion: Expression, displayExpression = true): void {
        this.expressionService.update(editedExpresion).subscribe(
          data => {
            this.reload();
            if(displayExpression){
              this.selectedExpression = editedExpression;
            }
             this.editExpression = null;
          },
          err => {
            console.log('Error updating expression: ' + err);
          }
        )
      };

        deleteSoundboard(id: number): void {
          // if (confirm('You sure about this?')) {
            // this.todos = this.todoService.index();
            // }
            this.soundboardService.destroy(id).subscribe(
              data =>{
                this.reload();
              },
              err => {
                console.log('Error deleting soundboard: ' + err);
              }
            );
        }
        deleteExpression(id: number): void {
          // if (confirm('You sure about this?')) {
            // this.todos = this.todoService.index();
            // }
            this.expressionService.destroy(id).subscribe(
              data =>{
                this.reload();
              },
              err => {
                console.log('Error deleting expression: ' + err);
              }
            );
        }
      }


