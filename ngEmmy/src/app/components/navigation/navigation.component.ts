import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { ProfileComponent } from '../profile/profile.component';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {

  constructor(
    private auth : AuthService,

    ) { }

  ngOnInit(): void {
  }

  loggedIn(): boolean {
    return this.auth.checkLogin();
  }
}
