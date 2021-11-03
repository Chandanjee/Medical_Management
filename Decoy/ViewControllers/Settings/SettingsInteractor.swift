//
//  SettingsInteractor.swift
//  Decoy
//
//  Created by mrigank.sahai on 14/10/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SettingsBusinessLogic
{
  func doSomething(request: Settings.Something.Request)
}

protocol SettingsDataStore
{
  //var name: String { get set }
}

class SettingsInteractor: SettingsBusinessLogic, SettingsDataStore
{
  var presenter: SettingsPresentationLogic?
  var worker: SettingsWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Settings.Something.Request)
  {
    worker = SettingsWorker()
    worker?.doSomeWork()
    
    let response = Settings.Something.Response()
    presenter?.presentSomething(response: response)
  }
}