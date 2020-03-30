//
//  IndicatorProtocol.swift
//  SimpleNote
//
//  Created by Admin on 11/03/2020.
//  Copyright © 2020 tap. All rights reserved.
//

import Foundation
import UIKit

public protocol IndicatorProtocol {
    /**
     Радиус индикатора.
     */
    var radius: CGFloat { get set }
    /**
     Базовый цвет индикатора.
     */
    var color: UIColor { get set }
    /**
     Статус анимации.
     */
    var isAnimating: Bool { get }
    /**
     Начать анимацию.
     */
    func startAnimating()
    /**
     Остановить анимацию и удалить слой.
     */
    func stopAnimating()
    /**
     Установить индикатор анимации.
     
     - Parameter layer: Слой для анимации.
     - Parameter size:  Размер анимации.
     */
    func setupAnimation(in layer: CALayer, size: CGSize)
}
