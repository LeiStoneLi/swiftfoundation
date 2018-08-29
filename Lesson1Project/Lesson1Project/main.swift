//
//  main.swift
//  Lesson1Project
//
//  Created by SrearAlex on 2016/12/12.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
 int a;
 未指定具体整型类型，默认为Int，平时指定时不需要指定具体类型
 */
var a = 10
a = 9
print(a)

/*
 常量不能被修改
 */
let id = 12345
print(id)
/*
 类型标注
 */
var x : Int
//x = 10.3
x = 10
let b: Int = 10
/*
名称不用再符合标识符的规范
 */
let 常量 = 10

/*
基本数据类型：整数类型，小数类型
 Int8/Int16/Int32/Int64
 UInt8/16/32/64
 Double：双精度64位/Float:单精度32位
 */
let interger: Int64 = 10
let unsignedInt: UInt32 = 19
let overValue: UInt8 = UInt8.max
var floatValue:Float = 3.2

/*
 两种类型可不可以进行隐式转换
 不可以
 */
var intVar: Int = 10
//var doubleVar: Double = intVar

/*
 类型推断(Swift编程语言特色)和类型安全
 */
let stringValue = "Hello"
var uint8Value: UInt8 = 9
var uint16Value: UInt16 = 9
/*
 类型不安全，编译不通过
var uint32Value: UInt32 = uint8Value + uint16Value
*/
/*
 类型转换,C语言中(类型）表达式
 产生临时变量，并不会改变原变量
 */
intVar = Int(floatValue)
print(intVar)//3
print(floatValue)//3.2
floatValue = Float(intVar)
print(floatValue)//3.0
var uint32Value: UInt32 = UInt32(uint8Value) + UInt32(uint16Value)

/*
 布尔类型,Bool:true,false
 */
let turnOffLight = true
/*
 if后面只能放布尔值，不支持非零为真
 */
if turnOffLight {
    print("Turn OFF")
} else {
    print("Turn ON")
}

/*
 元组:(30,"hello")
 */
/*let student: (String, Int, Double, Int) = ("zhangsan", 23, 98.5, 12)
 不用写的这么仔细
 */
let student = ("zhangsan", 23, 98.5, 12)
print(student.0)
print(student.1)
print(student.2)
let (name, age, score, _) = student
print(name, age, score)

let student1 = (name:"zhangsan", age:23)
print(student1.name)
print(student1.age)

/*
 可选值：optionals,有值，没有值（nil）
 可选值可以用if语句来判断的(swift3不支持，需加上 !=nil)
 */
var optValue: Int? = 9
var optValue2: Int? = nil
if optValue != nil {
    print(optValue)
}
//表示对可选值的一个强制解析，可选值！非常危险，不管有没有值，都去解包，如果没有值，不可以强制解析
var svalue:Int = optValue!
print(svalue)
//可选绑定
if var svalue2 = optValue2 {
    print(svalue)
}

/*
 隐式解析可选类型，两种状态，有值，没有值（nil）
 可选值可以用if语句来判断的(swift3不支持，需加上 !=nil)
 无论可选值强制解析，隐式解析都是十分危险的，除非确定不会被修改才可以直接使用（let）
 */
var impOptValue: Int! = nil
if impOptValue != nil {
    print(impOptValue)
}
if var ivalue = impOptValue {
    print(ivalue)
}
var ivalue: Int = impOptValue
//print(ivalue)
