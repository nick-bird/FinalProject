import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ProfileComponent } from './components/profile/profile.component';
import { HomePageComponent } from './components/home-page/home-page.component';
import { SoundboardComponent } from './models/soundboard/soundboard.component';
import { ExpressionComponent } from './models/expression/expression.component';
import { UserComponent } from './models/user/user.component';


@NgModule({
  declarations: [
    AppComponent,
    ProfileComponent,
    HomePageComponent,
    SoundboardComponent,
    ExpressionComponent,
    UserComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
