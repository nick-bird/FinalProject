import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.css']
})
export class UserProfileComponent implements OnInit {

  constructor(
    private userService: UserService
  ) { }

user: User = null;



  ngOnInit(): void {
 this.reload();
  }

reload(){

this.userService.getUser().subscribe(
  (user) => {
    this.user = user;
  },
 (err) => {
  console.log('Error loading user profile: ' + err);
  }
)

}


deactivateUser(){
   if (confirm('This action cannot be undone')) {
    }
  this.userService.deactivateUser(this.user).subscribe(
    (user) => {
      this.user = user;
    },
   (err) => {
    console.log('Error loading user profile: ' + err);
    }
  )
}



}
