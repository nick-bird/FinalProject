import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ProfileComponent } from './components/profile/profile.component';
import { HomePageComponent } from './components/home-page/home-page.component';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { AuthService } from './services/auth.service';
import { ExpressionService } from './services/expression.service';
import { SoundboardService } from './services/soundboard.service';

@NgModule({
  declarations: [
    AppComponent,
    ProfileComponent,
    HomePageComponent

  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule
  ],
  providers: [
    AuthService,
   ExpressionService,
   SoundboardService,
  AppRoutingModule],
  bootstrap: [AppComponent]
})
export class AppModule { }
