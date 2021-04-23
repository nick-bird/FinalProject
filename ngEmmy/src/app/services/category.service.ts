import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, tap } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';
import { Category } from '../models/category';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class CategoryService {

  constructor(private http : HttpClient,
    private auth: AuthService){}

  private baseUrl = 'http://localhost:8090/';
  private url = this.baseUrl + 'api/categories';


    getCategories() : Observable<Category[]>{

      return this.http.get<Category[]>(this.url, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error("CategoryService.getCategories: error retrieving list of categories: "+ err);
        return throwError(err);
        })
      );


  };

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
