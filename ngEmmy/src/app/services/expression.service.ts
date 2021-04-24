import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable, Output } from '@angular/core';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Expression } from '../models/expression';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class ExpressionService {

  constructor(
    private http: HttpClient,
    private auth: AuthService
  ) { }


  private baseUrl = 'http://localhost:8090/';
  private url = this.baseUrl + 'api/expressions';
  private url2 = this.baseUrl + 'api/public/expressions';
  private url3 = "http://api.voicerss.org/?key=b9e22d7d94624968a529973b64ea5de4&hl=en-us";
  private url4 = this.baseUrl + 'api/default/expressions';
 //private url = environment.baseUrl + 'api/expressions';



  index() {
    return this.http.get<Expression[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error getting expressions');
      })
    );
  }

  // --------------------API TEST----------------------

  // this.http.delete<Expression>(this.url + '/' + id, this.getHttpOptions())
  // API GET REQ: http://api.voicerss.org/?key=b9e22d7d94624968a529973b64ea5de4&hl=en-us&v=Evie&src=Hello

  indexPublic() {
    return this.http.get<Expression[]>(this.url2).pipe(
      catchError((err: any) => {
        return throwError('Error getting expressions');
      })
    );
  }

  indexDefaultExpressions() {
    return this.http.get<Expression[]>(this.url4,this.getHttpOptions()).pipe(
      catchError((err: any) => {
        return throwError('Error getting default expressions');
      })
    );
  }

  textToSpeech(voice, source) {
    return this.http.get<Output>(this.url3+"&v="+voice+"&src="+source).pipe(
      catchError((err: any) => {
        return throwError('Error getting expressions');
      })
    );
  }

  playAudio(voice, source) {
    let audio = new Audio();
    audio.src =(this.url3+"&v="+voice+"&src="+source);
    audio.load();
    audio.play();
  }

  // --------------------API TEST----------------------

  create(newExpression: Expression) {

    return this.http.post<Expression>(this.url, newExpression, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error creating expression');
      })
    );
  }
  update(editedExpression: Expression) {
    console.log(editedExpression);

    return this.http.put<Expression>(this.url + '/' + editedExpression.id, editedExpression, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error updating expression in service');
      })
    );
  }
  destroy(id: number) {

    return this.http.delete<Expression>(this.url + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error deleting expression in service');
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

