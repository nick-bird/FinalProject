import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
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
 //private url = environment.baseUrl + 'api/expressions';



  index() {
    return this.http.get<Expression[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error getting expressions');
      })
    );
  }

  indexPublic() {
    return this.http.get<Expression[]>(this.url2, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        return throwError('Error getting expressions');
      })
    );
  }

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

