//
//  main.swift
//  Initialization
//
//  Created by SrearAlex on 2016/12/29.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//

import Foundation

/*
 构造方法
 （1）构造方法初步
 （2）缺省构造方法
 （3）结构体的构造方法
 （4）可选值属性与构造方法
 （5）常量属性和构造方法
 （6）代理构造器
 */
/*
 (1）构造方法初步
 构造方法的主要作用：实例对象的内容的初始化
 Swift要求类或者结构体中的存储属性在对象构造完毕后要有初始值
 构造方法的语法：
 init(参数列表) {初始化代码}
 构造方法是隐式调用
 */
/*
 (2)带有缺省值的构造方法
 构造一个对象之后，要求对象中所有非lazy的存储属性必须有初始值（设置初始值一般在init方法中，带有缺省值的除外）
 */
/*
 (3)带有参数的构造方法
 */
class MyPoint {
    var x: Int = 0//存储属性
    var y: Int = 0
    
    func description() -> String {
        return "x=\(x), y=\(y)"
    }
    //构造方法的语法
//  init() {
//      x = 0
//      y = 0
//  }
    //属性带有缺省值隐式的提供了以下构造方法
//    init() {
//        x = 0
//        y = 0
//    }
}
//构造一个对象：（1）给对象分配内存（2）初始化这块儿内存（构造方法）
var p0 = MyPoint()
print(p0.description())//显示调用
/*
 (3)带有参数的构造方法
 */
class MyPoint1 {
    var x: Int//存储属性
    var y: Int
    
    func description() -> String {
        return "x=\(x), y=\(y)"
    }
    init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
}
var p1 = MyPoint1(x: 10, y: 10)
/*
 (4)常量存储属性与构造方法
 常量存储属性只能在构造方法中被修改，其他任何时候都不可以修改
 */
/*
 （5）可选值属性与构造方法
 */
class CreditCard {
    let cardNumber: UInt32
    init(number: UInt32) {
        self.cardNumber = number
    }
}
//可选值存储属性可以在构造方法中不进行初始化，nil
class Human {
    let name: String
    var age: Int
    var card: CreditCard?
    init(name: String, age: Int) {
        self.name = name
        self.age = age
//        self.card = CreditCard(number: 12334632)
    }
}
var person = Human(name: "xiaozhang", age: 10)
person.age = 11

/*
 结构体的构造方法总结
 */
struct Rect {
    var width: Double = 0.0
    var height: Double = 0.0
//    init(width: Double, height: Double) {
//        self.width = width
//        self.height = height
//    }
    //如果我们自定义了相应的构造方法，那么系统提供的结构体逐一成员构造方法将会失效
//    init() {
//        width = 0.0
//        height = 0.0
//    }
}
//针对结构体，系统会提供一个成员逐一构造器
var rect = Rect(width: 0.0, height: 0.0)
//当存储属性带缺省值，系统还会提供一个无参构造器
var rect1 = Rect()
/*
 (7)值类型的构造器代理
 直观一点儿就是“构造方法之间的相互调用”
 构造方法可以调用其他构造方法来完成实例的构造，称之为构造器代理
 好处，减少构造方法之间的代码重复
 */
struct Segment {
    var origin: Double
    var end: Double
    init(origin: Double, end: Double){
        self.origin = origin
        self.end = end
    }
    init() {
//        origin = 0.0
//        end = 0.0
        self.init(origin: 0.0, end: 0.0)
    }
    init(origin: Double, length: Double) {
//        self.origin = origin
//        self.end = origin + length
        self.init(origin: origin,end: origin+length)
    }
    func description() -> String {
        return "(\(origin), \(end))"
    }
}
var seg0 = Segment(origin: 0.0,end: 10.0)
var seg1 = Segment()
var seg2 = Segment(origin: 0.0, length: 10.0)
print(seg0.description())
print(seg2.description())
/*
 (8)闭包或者全局函数设置存储属性的缺省值
 构造方法中不能使用普通方法来设置初始值，因为self在所有的属性都被初始化后才能使用
 意义：需要通过运算，额外操作来设置存储属性初始值
 */
func getValue() -> Int {
    print("get value")
    return 10
}
class TestClass {
    //x是存储属性
    var x: Int = {
        
//        () -> Int in
        print("初始化开始")
        sleep(5)
        return 10
    }()
    
    //y是计算属性
    var y: Int {
        return x < 100 ? x : 100
    }
    var z: Int = getValue()
    //类方法来设置缺省值
    var w: Int = TestClass.classGetValue()
    init() {
//        x = 9
        print("初始化完毕")
    }
    //
    static func classGetValue() -> Int {
        print("class get value")
        return 10
    }

}
var obj = TestClass()
print(obj.x)
