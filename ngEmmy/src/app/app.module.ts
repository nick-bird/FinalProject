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
import { NotFoundComponent } from './components/not-found/not-found.component';
import { CategoryService } from './services/category.service';
import { ImageService } from './services/image.service';
import { NavigationComponent } from './components/navigation/navigation.component';
import { LogoutComponent } from './components/logout/logout.component';
import { MDBBootstrapModule } from 'angular-bootstrap-md';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatGridListModule } from '@angular/material/grid-list';
import {MatButtonModule} from '@angular/material/button';
import {MatIconModule} from '@angular/material/icon';
import { GridTestComponent } from './components/grid-test/grid-test.component';
import { TryComponent } from './components/try/try.component';


@NgModule({
  declarations: [
    AppComponent,
    ProfileComponent,
    HomePageComponent,
    NotFoundComponent,
    NavigationComponent,
    LogoutComponent,
    GridTestComponent,
    TryComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    MDBBootstrapModule.forRoot(),
    BrowserAnimationsModule,
    MatGridListModule,
    MatButtonModule,
    MatIconModule,

  ],
  providers: [
   AuthService,
   ExpressionService,
   SoundboardService,
   CategoryService,
   ImageService,
  AppRoutingModule],
  bootstrap: [AppComponent]
})
export class AppModule { }
