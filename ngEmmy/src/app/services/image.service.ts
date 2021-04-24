import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { Image } from '../models/image';
import { AuthService } from './auth.service';



@Injectable({
  providedIn: 'root'
})
export class ImageService {

  constructor(
    private http: HttpClient,
    private auth : AuthService
  ) { }


  private baseUrl = 'http://localhost:8090/';
  private url = this.baseUrl + 'api/images';

  index() : Observable<Image[]>{

    return this.http.get<Image[]>(this.url)
    .pipe(
      catchError((err: any) => {
        console.error("ImageService.index(): error retrieving list of images: "+ err);
      return throwError(err);
      })
    );


};

create(image: Image) : Observable<Image>{

  return this.http.post<Image>(this.url,image,this.getHttpOptions()).pipe(
    catchError((err: any)=> {
      console.error("ImageService.create(): error creating image: "+ err);
      return throwError(err);

    })
    );

};

// update(id: number, image: Image) : Observable<Image>{

//   return this.http.put<Image>(this.url +'/'+ id, image).pipe(
//     catchError((err: any)=> {
//       console.error("ImageService.update(): error updating image: "+ err);
//       return throwError(err);

//     })
//   );

// };

destroy(id: number){

  return this.http.delete<Image>(this.url +'/'+ id).pipe(
    catchError((err: any)=> {
      console.log("ImageService.destroy(): error deleting image: "+ err);
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








