//
//  SettingsPresenter.swift
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

protocol SettingsPresentationLogic
{
  func presentSomething(response: Settings.Something.Response)
}

class SettingsPresenter: SettingsPresentationLogic
{
  weak var viewController: SettingsDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Settings.Something.Response)
  {
    let viewModel = Settings.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
