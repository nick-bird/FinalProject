import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'ngEmmy';

  onRouteActivate(event: any) {
this.currentComponent=event.constructor.name;
  }

  getBackgroundClass() {
  }

  currentComponent = null;
}
