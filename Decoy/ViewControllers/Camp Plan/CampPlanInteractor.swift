//
//  CampPlanInteractor.swift
//  Decoy
//
//  Created by mrigank.sahai on 18/10/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CampPlanBusinessLogic
{
  func doSomething(request: CampPlan.Something.Request)
}

protocol CampPlanDataStore
{
  //var name: String { get set }
}

class CampPlanInteractor: CampPlanBusinessLogic, CampPlanDataStore
{
  var presenter: CampPlanPresentationLogic?
  var worker: CampPlanWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: CampPlan.Something.Request)
  {
    worker = CampPlanWorker()
    worker?.doSomeWork()
    
    let response = CampPlan.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
