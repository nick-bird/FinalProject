import { Component, OnInit } from '@angular/core';
import { Category } from 'src/app/models/category';
import { Expression } from 'src/app/models/expression';
import { Image } from 'src/app/models/image';
import { Soundboard } from 'src/app/models/soundboard';
import { SoundboardExpression } from 'src/app/models/soundboard-expression';
import { User } from 'src/app/models/user';
import { CategoryService } from 'src/app/services/category.service';
import { ExpressionService } from 'src/app/services/expression.service';
import { ImageService } from 'src/app/services/image.service';
import { SoundboardService } from 'src/app/services/soundboard.service';
import { UserService } from 'src/app/services/user.service';
import { NavigationComponent } from '../navigation/navigation.component';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css'],
})
export class ProfileComponent implements OnInit {
  constructor(
    private soundboardService: SoundboardService,
    private expressionService: ExpressionService,
    private catService: CategoryService,
    private imageService: ImageService,
    private userService: UserService
  ) {}

  ngOnInit(): void {
    this.reload();
  }

  defaultExpressions: Expression[] = [];
  publicSoundboards: Soundboard[] = [];

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

  newImage: Image = new Image();
  createdImage: Image = new Image();

  addCategories: Category[] = [];
  addSoundboardExpressions: SoundboardExpression[] = [];

  newSoundboardExpression: SoundboardExpression = new SoundboardExpression();

  tabIsActive1 = false;
  tabIsActive2 = false;
  tabIsActive3 = false;
  tabIsActive4 = false;
  soundboardBool: boolean = true;
  allExpressionsbool: boolean = false;
  userExpressionbool: boolean = false;
  publicSBBool: boolean = false;

  createSoundboard: boolean = false;
  createExpression: boolean = false;
  lockedbool: boolean = false;

  checkUser:User = new User();
  user:User;

  reload() {
    this.tabIsActive1 = true;
    this.publicSBBool = false;
    this.soundboardService.index().subscribe(
      (data) => {
        this.userSoundboards = data;

        // These Don't need to be loaded from the start
       // this.loadUserExpressions();
       // this.loadDefaultExpressions();
       // this.loadPublicSoundboards();
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
    );
  }

  loadUserExpressions() {
    this.tabIsActive1 = false;
    this.tabIsActive3 = false;
    this.tabIsActive4 = false;
    this.soundboardBool = false;
    this.allExpressionsbool = false;
    this.userExpressionbool = true;
    this.publicSBBool = false;
    this.expressionService.index().subscribe(
      (data) => {
        this.userExpressions = data;
      },
      (err) => {
        console.log('Error loading expressions: ' + err);
      }
    );
  }

  loadDefaultExpressions() {
    this.allExpressionsbool = true;
    this.soundboardBool = false;
    this.tabIsActive1 = false;
    this.tabIsActive2 = false;
    this.tabIsActive4 = false;
    this.userExpressionbool = false;
    this.publicSBBool = false;
    this.expressionService.indexDefaultExpressions().subscribe(
      (data) => {
        this.defaultExpressions = data;
      },
      (err) => {
        console.log('Error loading default expressions: ' + err);
      }
    );
  }

  loadPublicSoundboards() {
    this.publicSBBool = true;
    this.allExpressionsbool = false;
    this.soundboardBool = false;
    this.tabIsActive1 = false;
    this.tabIsActive2 = false;
    this.tabIsActive3 = false;
    this.userExpressionbool = false;
    console.log(this.publicSoundboards);

    this.soundboardService.indexPublic().subscribe(
      (data) => {
        this.publicSoundboards = data;
        console.log(this.publicSoundboards);
      },
      (err) => {
        console.log('Error loading public soundboards: ' + err);
      }
    );
  }

  createImage() {
    this.imageService.create(this.newImage).subscribe(
      (data) => {
        this.createdImage = data;
      },
      (err) => {
        console.log('Error creating image: ' + err);
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
    this.newSoundboard.categories = this.addCategories;
    this.newSoundboard.soundboardExpressions = this.addSoundboardExpressions;
    console.log(this.newSoundboard);

    this.soundboardService.create(this.newSoundboard).subscribe(
      (data) => {
        this.newSoundboard = data;
        this.displaySoundboard(this.newSoundboard);
        console.log(this.newSoundboard);

        this.reload();
        this.newSoundboard = new Soundboard();
      },
      (err) => {
        console.log('Error creating soundboard: ' + err);
      }
    );
  }

  addExpression(): void {
    console.log(this.newExpression);

    this.newExpression.image = this.createdImage;

    this.expressionService.create(this.newExpression).subscribe(
      (data) => {
        this.newExpression = data;
        this.displayExpression(this.newExpression);
        this.reload();
        this.newExpression = new Expression();
        this.newImage = new Image();
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

  toggleSoundBoard() {
    this.tabIsActive2 = false;
    this.tabIsActive3 = false;
    this.tabIsActive4 = false;
    this.userExpressionbool = false;
    this.publicSBBool = false;
    if (!this.soundboardBool) {
      return (this.soundboardBool = true);
    }
  }

  containsCategory = function (cat: Category) {
    for (let c of this.editSoundboard.categories) {
      if (c.name === cat.name) {
        return true;
      }
    }
    return false;
  };

  updateCategories(cat: Category) {
    if (this.containsCategory(cat)) {
      for (let i = 0; i < this.editSoundboard.categories.length; i++) {
        if (this.editSoundboard.categories[i].name === cat.name) {
          this.editSoundboard.categories.splice(i, 1);
        }
      }
    } else {
      this.editSoundboard.categories.push(cat);
    }
  }

  // update soundboards expressions

  containsExpression = function (exp: Expression) {
    for (let e of this.editSoundboard.soundboardExpressions) {
      if (e.expression.name === exp.name) {
        return true;
      }
    }
    return false;
  };

  updateExpressions(exp: Expression) {
    if (this.containsExpression(exp)) {
      for (let i = 0; i < this.editSoundboard.soundboardExpressions.length;i++
      ) {
        if (this.editSoundboard.soundboardExpressions[i].expression.name===
          exp.name) {
          this.editSoundboard.soundboardExpressions.splice(i, 1);
        }
      }
    } else {
      this.newSoundboardExpression = new SoundboardExpression();
      this.newSoundboardExpression.expression = exp;
      this.newSoundboardExpression.soundboard = new Soundboard();
      this.newSoundboardExpression.soundboard.id = this.editSoundboard.id;
      this.editSoundboard.soundboardExpressions.push(this.newSoundboardExpression);
      this.newSoundboardExpression = new SoundboardExpression();
    }
  }

  toggleTab() {
    return 'active';
  }

 // add soundboards categories when creating soundboard

  containsCategoryToAdd = function (cat: Category) {
    for (let c of this.addCategories) {
      if (c.name === cat.name) {
        return true;
      }
    }
    return false;
  };

  addCategoriesToSoundboard(cat: Category) {
    if (this.containsCategoryToAdd(cat)) {
      for (let i = 0; i < this.addCategories.length; i++) {
        if (this.addCategories[i].name === cat.name) {
          this.addCategories.splice(i, 1);
        }
      }
    } else {
      this.addCategories.push(cat);
      console.log(this.addCategories);
    }
  }

 //add soundboard expressions when creating soundboard

  containsExpressionToAdd = function (exp: Expression) {
    for (let e of this.addSoundboardExpressions) {
      if (e.expression.name === exp.name) {
        return true;
      }
    }
    return false;
  };

  addExpressions(exp: Expression) {
    if (this.containsExpressionToAdd(exp)) {
      for (let i = 0; i < this.addSoundboardExpressions.length; i++) {
        if (this.addSoundboardExpressions[i].expression.name === exp.name) {
          this.addSoundboardExpressions.splice(i, 1);
        }
      }
    } else {
      this.newSoundboardExpression = new SoundboardExpression();
      this.newSoundboardExpression.expression = exp;
      this.newSoundboardExpression.soundboard = new Soundboard();
      this.addSoundboardExpressions.push(this.newSoundboardExpression);
      console.log(this.addSoundboardExpressions);
      this.newSoundboardExpression = new SoundboardExpression();
    }
  }

  lock(){
    this.lockedbool = true;
    // this.navBar.lockedbool = true;
  }
  unlock(){
    this.lockedbool = false;
    this.selectedSoundboard = null;
  }
}
