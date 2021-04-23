import { TestBed } from '@angular/core/testing';

import { SoundboardExpressionService } from './soundboard-expression.service';

describe('SoundboardExpressionService', () => {
  let service: SoundboardExpressionService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SoundboardExpressionService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
