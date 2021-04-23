import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class SoundboardExpressionService {

  constructor(
    private http: HttpClient,
    private auth: AuthService
  ) { }

  private baseUrl = 'http://localhost:8090/';
  private url = this.baseUrl + 'api/soundboardexpressions';

}
