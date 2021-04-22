import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, tap } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';
import { Category } from '../models/category';

@Injectable({
  providedIn: 'root'
})
export class CategoryService {

  constructor(private http : HttpClient){}

  private baseUrl = 'http://localhost:8090/';
  private url = this.baseUrl + 'api/categories';


    getCategories() : Observable<Category[]>{

      return this.http.get<Category[]>(this.url)
      .pipe(
        catchError((err: any) => {
          console.error("CategoryService.getCategories: error retrieving list of categories: "+ err);
        return throwError(err);
        })
      );


  };
}
