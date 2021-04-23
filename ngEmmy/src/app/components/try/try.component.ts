import { Component, OnInit } from '@angular/core';
import { Expression } from 'src/app/models/expression';
import { ExpressionService } from 'src/app/services/expression.service';

@Component({
  selector: 'app-try',
  templateUrl: './try.component.html',
  styleUrls: ['./try.component.css']
})
export class TryComponent implements OnInit {

  constructor(private expressionService: ExpressionService) { }

  ngOnInit(): void {
    this.reload();
  }

  expressions: Expression[] = [];
  selectedExpression: Expression = null;

  reload() {
    this.expressionService.indexPublic().subscribe(
      data => {
        this.expressions = data;
      },
      err => {
        console.log('Error loading expressions: ' + err);
      }
    );
    }

    displayExpression(expression: Expression): void {
    this.selectedExpression = expression;
  }
}

