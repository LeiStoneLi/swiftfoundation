//
//  main.swift
//  Function
//
//  Created by SrearAlex on 2016/12/14.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//

import Foundation
/*
 (1)函数的定义和调用
    函数的概念：完成某个特定任务的代码块，给代码块起一个合适的名字，称之为函数名，简单来说，当函数需要被执行的时候，调用这个名字就可以了
    函数的分类：（1）程序员自定义并实现的函数。（2）“他人”定义实现的函数
    swift函数定义的语法：
    func 函数名(参数名：参数类型，参数名：参数类型 ...) -> 函数返回值类型 {
        函数实现部分...
    }
    swift函数调用语法：
    函数名(实际参数...）
 */
//函数的定义 ，附不换行输出的方法print(,terminator:"")
func showIntegerArray(array: [Int]) {
    for a in array {
        print("\(a) ", terminator:"")
    }
    print()
}
showIntegerArray(array: [1,2,3,4,5])
/*
 (2)函数的参数和返回值
 1.函数可以有多个参数
 2.函数可以没有返回值也没有参数
 3.函数可以有多个返回值
 */
func maxOfValue(a: Int, b: Int) -> Int{
    if a > b {
        return a
    } else {
        return b
    }
}
print(maxOfValue(a: 4, b: 2))
//没有返回值省略 -> 返回值类型   或者  -> Void
func showHelloWorld() {
    print("Hello World")
}
func showHelloWorld2() -> Void {
    print("Hello World")
}
showHelloWorld2()

let p0: (Double, Double) = (0, 0)
let p1: (Double, Double) = (6, 6)
func getLengthAndWidth(p0: (Double, Double), p1: (Double,Double)) -> (Double, Double) {
    return(abs(p0.1 - p1.1), abs(p0.0 - p1.1))
}
print(getLengthAndWidth(p0: p0, p1: p1))

func getLengthAndWidth1(p0: (Double, Double), p1: (Double,Double)) -> (length: Double, width: Double) {
    return(abs(p0.1 - p1.1), abs(p0.0 - p1.1))
}

let width = getLengthAndWidth1(p0: p0, p1: p1).width
let length = getLengthAndWidth1(p0: p0, p1: p1).length
print("\(length): \(width)")
let p2: (x: Double, y: Double) = (0, 0)
let p3: (x: Double, y: Double) = (6, 6)

func getLengthAndWidth2(p0: (x: Double, y: Double), p1: (x: Double, y: Double)) -> (length: Double, width: Double) {
    return(abs(p0.y - p1.y), abs(p0.x - p1.x))
}
let width1 = getLengthAndWidth2(p0: p2, p1: p3).width
let length1 = getLengthAndWidth2(p0: p2, p1: p3).length
print("\(length): \(width)")
//（3）函数的实际参数标签和形式参数名, 实际参数标签用在调用函数的，在调用函数的时候每一个实际函数前边都要写实际参数标签。形式参数名用在函数的实际当中。默认情况下，使用它们的形式参数名作为实际参数标签
//下面的例子 默认情况下，形式参数省略的情况
//func divisionOperation(divident: Double, divisor: Double) -> Double {
//    return divident / divisor
//}
//let res = divisionOperation(divident: 3.5, divisor: 1.2)
//print(res)

//等价于 
//func divisionOperation1(divident divident: Double, divisor divisor: Double) -> Double {
//    return divident / divisor
//}
//let res = divisionOperation1(divident: 3.5, divisor: 1.2)
//print(res)
//省略实际参数标签
//如果对于函数的形式参数不想使用实际参数标签的话，可以利用下划线（_）来为这个形式参数代替显式的实际参数标签
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    //In the function body，firstParameterName and secondParameterName refer to the argument values for the first and second parameters
    
}
someFunction(1, secondParameterName: 2)
/*
 （4）函数的默认形式参数值
 通过在形式参数类型后给形式参数赋值来给函数的任意形式参数定义一个默认值。如果定义了默认值，就可以在调用的时候省略这个形式参数
 把不带默认值的形式参数放到函数的形式参数列表中带有默认值的形式参数前边，不带有默认值的形式参数通常对函数有重要的意义——把它们写在前边可以便于让人们看出来无论是否省略带默认值的形式参数，调用的都是同一个函数   带有默认值的形式参数也可以放在前面
 */
// "hello", "world", joiner: "#" ————> "hello#world"
func joinString(s1: String, s2: String, joiner: String) -> String {
    return s1 + joiner + s2
}
let str = joinString(s1: "hello", s2: "world", joiner: "#")
print(str)
func joinString2(s1: String, joiner:String = "?", s2: String) -> String {
    return s1 + joiner + s2
}
let str2 = joinString2(s1: "hello", s2: "world")
print(str2)
let str3 = joinString2(s1: "hello", joiner: "#", s2: "world")
print(str3)
//（5）可变形式参数
//一个可变形式参数可以接受零或者多个特定类型的值，当调用函数的时候，可以利用可变形式参数来声明形式参数可以被传入值的数量是可变的。可以通过在形式参数的类型名称后边插入三个点符号（ ... )来书写可变形式参数
//传入到可变参数中的值在函数的主体中被当作是对应类型的数组，举个例子，一个可变参数的名称numbers类型是Double，在函数的主体中它会被当作名字是numbers类型是 [Double]的常量数组
//举个例子 计算一组任意长度的数字的算术平均值（平均数）
//注意
//一个函数最多只能有一个可变形式参数
func arithmeticMean(numbers: Double ... ) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
print(arithmeticMean(numbers: 1, 2, 3, 4, 5))
print(arithmeticMean(numbers: 3, 8.25, 18.75))
//(6)输入输出形式参数
//可变形式参数只能在函数的内部做改变，如果想要函数能够修改一个形式参数的值，而且你想这些改变在函数结束之后依然生效，那么就需要将形式参数定义为输入输出形式参数
//在形式参数定义开始的时候在前边添加一个inout关键字可以定义一个输入输出形式参数。输入输出形式参数有一个能输入给函数的值，函数能对其进行修改，还能输出到函数外边替换原来的值。
//你只能把变量作为输入输出形式参数的实际参数，你不能用常量或者字面量作为实际参数，因为常量和字面量不能修改。在将变量作为实际参数传递给输入输出形式参数的时候，直接在它前边添加一个和符号（&）来明确可以被函数修改
//输入输出形式参数不能有默认值，可变形式参数不能标记为inout，如果给一个形式参数标记了inout，那么她们也不能标记var 和 let了
//交换两个变量的值
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swap(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
//输入输出形式参数与函数的返回值不同。上边的 swapTwoInts没有定义返回类型和返回值，但它仍然能修改 someInt和 anotherInt的值。输入输出形式参数是函数能影响到函数范围外的另一种替代方式。

/*
 函数类型
 每一个函数都有一个函数类型，由形式参数和返回值类型组成
 */
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
//这两个函数的函数类型都是 (Int, Int) -> Int 。也读作：
//有两个形式参数的函数，它们都是Int类型，并且返回一个Int类型的值。
//有两个都是Int类型的形式参数，并且返回一个Int类型的值的函数类型
func printHelloWorld() {
    print("hello, world")
}
//这个函数的类型是() -> Void ,或者“一个没有形式参数的函数，返回Void。”
//使用函数的类型
//函数类型变量
//你可以像使用 Swift 中的其他类型一样使用函数类型。例如，你可以给一个常量或变量定义一个函数类型，并且为变量指定一个相应的函数。
var mathFunction: (Int, Int) -> Int = addTwoInts
//读作：“定义一个叫做mathFunction的变量，它的类型是 ”一个能接受两个Int值的函数，并返回一个Int值。‘将这个新的变量指向addtwoInts函数。
//这个addtwoInts(_:_:)函数和mathFunction函数有相同的类型，所以这个赋值是可以通过Swift的类型检查的
print("Result: \(mathFunction(2, 3))")

//不同的函数如果有相同的匹配的话，就可以指定相同的变量，和非函数的类型一样
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")

//当指定一个函数为常量或者变量的时候，可以将它留给Swift来对其进行类型推断
let anotherMathFunction = addTwoInts

//函数类型作为形式参数类型
//可以利用一个函数的类型例如 (Int, Int) -> Int 作为其他函数的形式参数类型。这允许你预留函数的部分实现从而让函数的调用则在调用函数的时候提供

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)

//函数类型作为返回类型
//利用函数类型作为另一个函数的返回类型。写法是在函数的返回箭头（->)后立即下一个完整的函数类型。
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
//函数chooseStepFunction(backward: ),它的返回类型是“一个函数的类型（Int) -> Int".函数chooseStepFunction(backwards:)返回了stepForward(_:)函数或者一个基于叫做backwards的布尔量形式参数的函数stepBackward(_:)
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward: stepForward
}
var currentValue = 3
let moveNearToZero = chooseStepFunction(backward: currentValue > 0)
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearToZero(currentValue)
}
print("zero!")

//内嵌函数
//在函数的内部定义另外一个函数，内嵌函数
//内嵌函数在默认情况下在是被隐藏起来的，但却仍然可以通过包裹它们的函数来调用它们。包裹的函数也可以返回它内部的一个内嵌函数来在另外的范围里使用
func chooseStepFunction2(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    return backward ? stepBackward : stepForward
}
currentValue  = -4
let moveNearToZero2 = chooseStepFunction2(backward: currentValue > 0)
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearToZero2(currentValue)
}
print("zero!")

func bubbleSort(array: inout [Int]){
    let cnt = array.count
    func swapValue(a: inout Int, b: inout Int){
        print("数组元素的个数\(cnt)")
        let t = a
        a = b
        b = t
    }
    for i in 1 ..< cnt {
        for j in 0 ..< cnt-i {
            if(array[j] > array[j+1]){
                swapValue(a: &array[j], b: &array[j+1])
            }
        }
    }
    
}
