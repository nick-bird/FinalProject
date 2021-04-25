import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserService {

    //private baseUrl = environment.baseUrl;
    private baseUrl = 'http://localhost:8090/';

    constructor(
      private http: HttpClient,
      private auth: AuthService
      ) { }


getUser(): Observable<User> {
return this.http.get<User>(this.baseUrl + 'api/userprofile', this.getHttpOptions()).pipe(catchError((err: any) => {
  console.log(err);
  return throwError('Error getting user profile');
})
);
}

deactivateUser(user: User){
  console.log(user.id);
return this.http.put<User>(this.baseUrl + 'deactivate/' +  user.id, user).pipe(catchError((err: any) => {
  console.log(err);
  return throwError('Error deactivating user profile');
})

);
}


 private getHttpOptions(): object {
    const credentials = this.auth.getCredentials();
    // Send credentials as Authorization header (this is spring security convention for basic auth)
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest',
      }),
    };
    return httpOptions;
  }

}
