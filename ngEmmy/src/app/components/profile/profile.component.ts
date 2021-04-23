import { Component, OnInit } from '@angular/core';
import { Category } from 'src/app/models/category';
import { Expression } from 'src/app/models/expression';
import { Image } from 'src/app/models/image';
import { Soundboard } from 'src/app/models/soundboard';
import { SoundboardExpression } from 'src/app/models/soundboard-expression';
import { CategoryService } from 'src/app/services/category.service';
import { ExpressionService } from 'src/app/services/expression.service';
import { SoundboardService } from 'src/app/services/soundboard.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css'],
})
export class ProfileComponent implements OnInit {
  constructor(
    private soundboardService: SoundboardService,
    private expressionService: ExpressionService,
    private catService: CategoryService
  ) {}

  ngOnInit(): void {
    this.reload();
  }

  soundboards: Soundboard[] = [];
  expressions: Expression[] = [];
  selectedSoundboard: Soundboard = null;
  selectedExpression: Expression = null;

  userExpressions: Expression[] = [];
  userSoundboards: Soundboard[] = [];
  newSoundboard: Soundboard = new Soundboard();
  newExpression: Expression = new Expression();
  editSoundboard: Soundboard = null;
  editExpression: Expression = null;

  categories: Category[] = [];

  newImage : Image = new Image();

  newSoundboardExpression : SoundboardExpression = new SoundboardExpression();

  soundboardBool: boolean = true;
  tabIsActive1 = false;
  tabIsActive2 = false;
  tabIsActive3 = false;
  tabIsActive4 = false;

  reload() {
    this.soundboardService.index().subscribe(
      (data) => {
        this.userSoundboards = data;
        this.loadUserExpressions();
      },
      (err) => {
        console.log('Error loading soundboards: ' + err);
      }
    );
    this.catService.getCategories().subscribe(
      (categories) => {
        this.categories = categories;

      },
      (err) => {
        console.log('Error loading categories: ' + err);
      }
    )
  }

  loadUserExpressions() {
    this.expressionService.index().subscribe(
      (data) => {
        this.userExpressions = data;
      },
      (err) => {
        console.log('Error loading expressions: ' + err);
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
      (data) => {
        this.displaySoundboard(this.newSoundboard);
      },
      (err) => {
        console.log('Error creating todo: ' + err);
      }
    );
  }

  addExpression(): void {
    console.log(this.newExpression);

    // this.newExpression.image.imageUrl = this.newImage.imageUrl;

    this.expressionService.create(this.newExpression).subscribe(
      (data) => {
        this.displayExpression(this.newExpression);
      },
      (err) => {
        console.log('Error creating expression: ' + err);
      }
    );
  }

  setEditExpression(): void {
    this.editExpression = Object.assign({}, this.selectedExpression);
  }
  setEditSoundboard(): void {
    this.editSoundboard = Object.assign({}, this.selectedSoundboard);
  }
  updateSoundboard(
    editedSoundboard: Soundboard,
    displaySoundboard = true
  ): void {
    this.soundboardService.update(editedSoundboard).subscribe(
      (data) => {
        this.reload();
        if (displaySoundboard) {
          this.selectedSoundboard = editedSoundboard;
        }
        this.editSoundboard = null;
      },
      (err) => {
        console.log('Error updating soundboard: ' + err);
      }
    );
  }
  updateExpression(
    editedExpression: Expression,
    displayExpression = true
  ): void {
    this.expressionService.update(editedExpression).subscribe(
      (data) => {
        this.reload();
        if (displayExpression) {
          this.selectedExpression = editedExpression;
        }
        this.editExpression = null;
      },
      (err) => {
        console.log('Error updating expression: ' + err);
      }
    );
  }

  deleteSoundboard(id: number): void {
    // if (confirm('You sure about this?')) {
    // }
    this.soundboardService.destroy(id).subscribe(
      (data) => {
        this.reload();
      },
      (err) => {
        console.log('Error deleting soundboard: ' + err);
      }
    );
  }
  deleteExpression(id: number): void {
    // if (confirm('You sure about this?')) {
    // }
    this.expressionService.destroy(id).subscribe(
      (data) => {
        this.reload();
      },
      (err) => {
        console.log('Error deleting expression: ' + err);
      }
    );
  }

  toggleSoundBoard(){
    this.tabIsActive1 = false;
    this.tabIsActive2 = false;
    if (this.soundboardBool){
      return this.soundboardBool = false;
     }
     if (!this.soundboardBool){
      return this.soundboardBool = true;
     }
  }


  containsCategory = function(cat: Category){
    for (let c of this.editSoundboard.categories){
    if (c.name === cat.name){
    return true;
    }
    }
    return false;
    }

    updateCategories(cat: Category){
    if(this.containsCategory(cat)){
    for (let i = 0; i < this.editSoundboard.categories.length; i++){
    if (this.editSoundboard.categories[i].name === cat.name){
    this.editSoundboard.categories.splice(i, 1);
    }
    }
    }
    else {
    this.editSoundboard.categories.push(cat);
    }
    }


// update soundboards expressions

    containsExpression = function(exp: Expression){
      for (let e of this.editSoundboard.soundboardExpressions){
      if (e.expression.name === exp.name){
      return true;
      }
      }
      return false;
      }

      updateExpressions(exp: Expression){
      if(this.containsExpression(exp)){
      for (let i = 0; i < this.editSoundboard.soundboardExpressions.length; i++){
      if (this.editSoundboard.soundboardExpressions[i].expression.name=== exp.name){
      this.editSoundboard.soundboardExpressions.splice(i, 1);
      }
      }
      }
      else {
      this.editSoundboard.soundboardExpressions.push();
      }
      }




  toggleTab(){
    return "active";
    }


}
