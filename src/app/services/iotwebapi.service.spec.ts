import { TestBed } from '@angular/core/testing';

import { IotwebapiService } from './iotwebapi.service';

describe('IotwebapiService', () => {
  let service: IotwebapiService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(IotwebapiService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
