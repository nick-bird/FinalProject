import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-home-page',
  templateUrl: './home-page.component.html',
  styleUrls: ['./home-page.component.css']
})
export class HomePageComponent implements OnInit {

  constructor(
    private auth: AuthService,
    private router: Router

  ) { }
  user: User = new User();
  newUser: User = new User();
  ngOnInit(): void {
  }

  login(){
    this.auth.login(this.user.username,this.user.password).subscribe(
      loggedIn => {
        console.log('Logged in');
       this.router.navigateByUrl('/profile');

      },
      denied =>{
        console.error('login() failed');
        console.error('denied');
      }
    )
  }

  register() {
    this.auth.register(this.newUser).subscribe(
      data => {
        console.log('HomePage.register(): user registered.');
        this.auth.login(this.newUser.username, this.newUser.password).subscribe(
          next => {
            console.log('HomePage.register(): user logged in, routing to /profile.');
           this.router.navigateByUrl('/profile');
          },
          error => {
            console.error('HomePage.register(): error logging in.');
          }
        );
      },
      err => {
        console.error('HomePage.register(): error registering.');
        console.error(err);
      }
    );
  }

}
