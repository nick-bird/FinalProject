import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Soundboard } from '../models/soundboard';
import { AuthService } from './auth.service';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SoundboardService {

  constructor(
    private http: HttpClient,
    private auth: AuthService
  ) { }


  private baseUrl = 'http://localhost:8090/';
  private url = this.baseUrl + 'api/soundboards';
 //private url = environment.baseUrl + 'api/soundboards';



  index() {
    return this.http.get<Soundboard[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error getting soundboards');
      })
    );
  }
  create(newSoundboard: Soundboard) {

    return this.http.post<Soundboard>(this.url, newSoundboard, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error creating soundboard');
      })
    );
  }
  update(editedSoundboard: Soundboard) {
    console.log(editedSoundboard);

    return this.http.put<Soundboard>(this.url + '/' + editedSoundboard.id, editedSoundboard, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error updating soundboard in service');
      })
    );
  }
  destroy(id: number) {

    return this.http.delete<Soundboard>(this.url + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error deleting soundboard in service');
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





