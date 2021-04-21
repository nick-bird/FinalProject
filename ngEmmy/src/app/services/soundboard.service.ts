import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Soundboard } from '../models/soundboard';
import { AuthService } from './auth.service';
import { catchError, tap } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';

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
    newTodo.completed = false;
    newTodo.description = '';
    return this.http.post<Todo>(this.url, newTodo, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error creating todo');
      })
    );
  }
  update(editedTodo: Todo) {
    console.log(editedTodo);

    if (editedTodo.completed === true) {
      editedTodo.completeDate = this.datePipe.transform(
        Date.now(),
        'shortDate'
      );
    } else {
      editedTodo.completeDate = '';
    }
    console.log(editedTodo);
    return this.http.put<Todo>(this.url + '/' + editedTodo.id, editedTodo, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error updating todo in service');
      })
    );
  }
  destroy(id: number) {

    return this.http.delete<Todo>(this.url + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error deleting todo in service');
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




}
