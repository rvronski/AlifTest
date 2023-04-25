//
//  TestNumberOne.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import Foundation

// 1 задание - Заменить в массиве отрицательные числа нулем

var array:[Int] = [1,2,4,-5,7,-10,-15]

func replaceNegativeNumbers(array: [Int]) -> [Int] {
    var newArray = array
    for i in 0..<newArray.count {
        if newArray[i] < 0 {
            newArray[i] = 0
        }
    }
    return newArray
}

// 2 задание - Сортировка массива по убыванию(возрастанию)

var newArray = array.sorted(by: >)

// 3 задание - Найти max(min) элемент в массиве

var max = array.max()
var min = array.min()

// 4 задание - Найти сумму элементов массива

func sumArray() -> Int {
    var result = 0
    for number in array {
        result += number
    }
    return result
}


