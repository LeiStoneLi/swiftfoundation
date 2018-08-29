//
//  main.swift
//  Enumerations
//
//  Created by SrearAlex on 2016/12/19.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//

import Foundation

/*
 Swift枚举：
 定义了一组通用类型的相关值，从而可以在代码中类型安全地操作这些值
 （1）枚举基本语法
 除了增加程序可读性，枚举是一等类型，可以增加属性和方法
 */
enum Method {
//    case Add
//    case Subtract
//    case Multiply
//    case Divide
    case Add, Subtract, Multiply, Divide
}
var m0: Method = .Add
var m1 = Method.Subtract
enum CompassPoint {
    case north
    case south
    case east
    case west
}
//多个成员值可以写在同一行，用逗号隔开
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn,uranus, natune
}
//枚举类型的名称要首字母大写，给枚举类型定义一个单数的而不是附属的名字，从而
var directionToHead = CompassPoint.west

//当与CompassPoint中可用的某一值一同初始化时directionToHead的类型会被推断出来，一旦directionToHead以CompassPoint类型被声明出来，就可以用一个点语法把它设定成不同的CompassPoint值
directionToHead = .east
//directionToHead的类型是已知的，所以当设定他的值的时候可以不用写类型，这样做可以使得在操作确定类型的枚举时，让代码非常易读

/*
 使用Switch语句来匹配枚举值
 */
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Most harmless")
default:
    print("Not a safe place for humans")
}

//关联值
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
enum LineSegmentDescriptor {
    case startAndEndPattern(start: Double, end: Double)
    case startAndLengthPattern(start: Double, length: Double)
}
var lsd = LineSegmentDescriptor.startAndEndPattern(start: 10, end: 20)
lsd = LineSegmentDescriptor.startAndLengthPattern(start: 10, length: 10)
//读作:定义一个叫做barcode的枚举类型，它要么用（Int，Int，Int，Int）类型的关联值获取upc值，要么用String类型的关联值获取qrCode值
//该定义并不提供任何实际的Int或者String的值——它只定义当Barcode常量和变量与BarCode.upc或者Barcode.qrCode相同时可以储存的关联值的类型
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
switch productBarcode {
case .upc(let numberSystem, let manuFacturer, let product, let check):
    print("UPC:\(numberSystem), \(manuFacturer), \(product), \(check)")
case .qrCode(let productCode):
    print("QR code:\(productCode)")
}
//UPC:8, 85909, 51226, 3
//创建累一个叫做productBarcode的新变量，而且给它赋值了一个Barcode.upc的值关联了值为 （8， 85909， 51226， 3）
productBarcode = Barcode.qrCode("ABCDEFGHIJKLMNOP")
//最初的Barcode.upc和它的整数值将被新的Barcode.qrCode和它的字符串值替代。Barcode类型的常量和变量可以储存一个 　.upc或一个 .qrCode（和它们的相关值一起存储）中的任意一个。但是它们只可以在给定的时间内存储它们其中之一


//提取枚举值

switch productBarcode {
case .upc(let numberSystem, let manuFacturer, let product, let check):
    print("UPC:\(numberSystem), \(manuFacturer), \(product), \(check)")
case .qrCode(let productCode):
    print("QR code:\(productCode)")
}
//QR code:ABCDEFGHIJKLMNOP

//如果对于一个枚举成员的所有的相关值都被提取为常量，或如果都被提取为变量，为了简洁，可以用一个单独的 var 或 let 在成员名称前标注：
switch productBarcode {
case let .upc(numberSystem, manuFacturer, product, check):
    print("UPC:\(numberSystem), \(manuFacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code:\(productCode)")
}

//原始值
//关联值中展示了枚举成员是如何声明它们存储不同类型的相关值。作为相关值的另一种选择，枚举成员可以用相同类型的默认值预先填充（原始值）
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
//一个叫做ASCIIControlCharacter的枚举原始值被定义为类型Character，并且被放置在了更多的ASCII控制符中

//注意： 原始值与关联值不同，原始值是当第一次定义枚举的时候，它们用来预先填充的值，正如上面的三个ASCII码。特定枚举成员的原始值是始终相同的，关联值在你基于枚举成员的其中之一创建新的常量或者变量时设定，并且在每次这么做的时候这些关联值可以不同

//隐式指定的原始值
//当在操作存储整数或字符串原始值枚举的时候，不必显式地给每一个成员都分配一个原始值。当没有分配时，Swift将会自动分配值
//实际上，当整数值被用于作为原始值时，每成员的隐式值都比前一个大一，如果第一个成员没有值，那么它的值是0

enum Planet2: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
//Planet2.mercury有一个明确的原始值 1，Planet.venus的隐式原始值是2 ，以此类推

//当字符串被用于原始值时，那么每一个成员的隐式原始值则是那个成员的名称
enum CompassPoint2: String {
    case north
    case south
    case east
    case west
}

//CompassPoint2.south有一个隐式原始值“south”，以此类推

//可以使用rawValue属性来访问一个枚举成员的原始值：
let earthsOrder = Planet2.earth.rawValue
print("earth's order is \(earthsOrder)")
let sunsetDirection = CompassPoint2.west.rawValue
print("sunsetDirection is \(sunsetDirection)")

//从原始值初始化
//如果你用原始值类型来定义一个枚举，那么枚举就会自动收到一个可以接受原始值类型的值的初始化器（叫做rawValue的形式参数）然后返回一个枚举成员或者nil。可以使用这个初始化器来曾是创建一个枚举的新实例。
let possiblePlanet: Planet2? = Planet2(rawValue: 7)
//不是所有可能的Int值都会对应一个行星，因此原始值的初始化器总是返回可选的枚举成员，possiblePlanet的类型是Planet?,或者“可选项Planet2”
//注意：原始化初始化器是一个可失败初始化器，因为不是所有原始值都将返回一个枚举成员

let positionToFind = 11
if let somePlanet = Planet2(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There is not a planet at position \(positionToFind)")
}

//递归枚举
//枚举在对序号考虑固定数量可能性的数据建模时表现良好，比如用来做简单整数运算的运算符。这些运算符允许组合简单的整数数学运算表达式比如5道更复杂的比如5+4
//数学表达式的一大特征就是它们可以内嵌，比如说，表达式（5+4）*2在乘法右ce有一个数但其他表达式在乘法的左手侧，因为数据被内嵌，用来存储数据的枚举同样需要支持内嵌——这意味着枚举需要被递归
//递归枚举是拥有另一个枚举作为成员关联值的枚举。当编译器操作递归枚举时必须插入简介寻址层。可以在声明枚举成员之前使用indirect关键字来明确它是递归的

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression,ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression,ArithmeticExpression)
}

//同样可以在枚举之前写indirect 来让整个枚举成员在需要时可以递归：
indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2,ArithmeticExpression2)
    case multiplication(ArithmeticExpression2,ArithmeticExpression2)
}
//这个枚举可以存储三种数学运算表达式：单一的数字，两个两个表达式的加法，以及两个表达式的乘法。addition和multiplication成员拥有同样是数学表达式的关联值——这些关联值让嵌套表达成为可能。比如说，表达式(5+4)*2的乘号右侧有一个数字左侧有其他表达式，。由于数据是内嵌的，用来储存数据的枚举同样需要支持内嵌，——这就是说枚举需要递归，下边的代码展示了为（5 + 4）*2创建的递归枚举ArithmeticExpression：
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

//递归函数是一种操作递归结构数据的简单方法，比如说，这里有一个判断数学表达式的函数
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))
