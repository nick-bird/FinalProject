import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { Image } from '../models/image';



@Injectable({
  providedIn: 'root'
})
export class ImageService {

  constructor(
    private http: HttpClient
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

  return this.http.post<Image>(this.url,image).pipe(
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

}








