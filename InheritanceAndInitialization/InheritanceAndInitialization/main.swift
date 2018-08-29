//
//  main.swift
//  InheritanceAndInitialization
//
//  Created by SrearAlex on 2016/12/30.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//

import Foundation

/*
 继承与构造方法
 （1）指定构造与便利构造方法解析
 （2）派生类的构造方法
 （3）构造器链和安全检查深入解析
 （4）派生类的构造方法默认继承
 （5）构造方法的重写
 （6）必须构造方法
 （7）析构方法
 */

/*
 (1)指定构造与便利构造方法解析（Designated Initializers and Convenience Initializers)
 */
class AB {
    var a: Int
    var b: Int
    //指定构造方法，不允许出现构造器代理，self.init(...)
    init(b: Int){
        self.a = 0
        self.b = b
    }
    //指定构造方法
    init(a: Int, b: Int) {
        self.a = a
        self.b = b
        print("Class AB init!")
    }
    //便利构造方法——》一定是通过调用其他的构造方法来实现初始化，一定要出现self.init(...)
    //意义：为了书写构造方法更简单，简洁代码
    convenience init (a: Int) {
//        self.a = a
//        b = 0
        self.init(a: a, b: 0)
    }
    convenience init() {
//        self.init(a: 0, b: 0)//可以使用指定构造方法，也可以使用便利构造方法
        self.init(a: 0)
    }
}
/*
 (2)派生类的构造方法
 */
/*
 (3)构造器链——指定构造器和便利构造器之间的调用规则
 a.指定构造器必须调用其直接父类的指定构造器。
 b.便利构造器必须调用同类中定义的其他构造器（指定构造器，便利构造器）
 c.便利构造器必须最终以调用一个指定构造器结束
 指定构造器总是向上代理，便利构造器总是横向代理
 */
class CD: AB {
    var c: Int
    var d: Int
    //构造方法默认是不会被继承，基类的存储属性只能通过基类的构造方法来初始化
    //派生类引入的存储属性要先被初始化，然后再调用父类的构造方法对父类的属性进行初始化
    //我们只能通过调用父类的指定构造方法来对父类的属性进行初始化
    
    //指定构造器
    init(c: Int, d: Int) {
        self.c = c
        self.d = d
        super.init(a: 0,b :0)//可以
//        super.init(b: 0)//可以
//        super.init(a: 0)//不可以
    }
    
    //便利构造器,只能通过调用本类中的构造器完成初始化
    convenience init(a: Int, b: Int, c: Int, d: Int) {
        self.init(c: c, d: d)
/*
        self.c = c
        self.d = d
        super.init(a: a, b: b)
 */
    }
}
/*
 （4）两段式构造——构造过程可以划分为两个阶段
 第一阶段，确保所有的存储属性都初始化完毕
 第二阶段，对父类中的存储属性做进一步的处理。
 可以防止属性在被初始化之前访问，也可以防止属性被另外一个构造器意味的赋值
 */
/*
 （5）派生类构造方法定义时的编译器安全性检查
 a.首先应该将派生类引入的存储属性初始化，然后再向上调用父类的指定构造方法
 b.首先调用父类中的指定构造器实现父类中属性的初始化之后，才可以访问父类中的属性
 c.在编写便利构造器时，必须先调用同一个类中的其他构造方法，然后才可以访问任意属性
 d.在第一阶段完成之前，不能调用任何实例方法，不能访问任何父类中定义的存储属性，也不能引用self
 */
class A {
    var a: Int
    init(a: Int) {
        self.a = a
    }
}
class B: A {
    var b: Int
    init(a: Int, b: Int){
        //派生类引入的属性进行初始化
        print("类B的第一阶段初始化开始")
        self.b = b
        //父类的指定构造方法对父类的属性进行初始化
//        if (b>1000) {
//            self.a = 1000
//        }
        super.init(a:a)
        
        print("类B的第二阶段初始化开始")
        if(b>1000){
            self.a = 1000
        }
    }
}
class C: B {
    var c: Int
    init(a: Int, b: Int, c: Int){
        //派生类引入的属性进行初始化
        print("类C的第一阶段初始化开始")
        self.c = c
        //父类的指定构造方法对父类的属性进行初始化
        super.init(a:a,b:b)
        
        print("类C的第二阶段初始化开始")
        if(c>1000){
            self.a = 1000
            self.b = 1000
        }
    }
}
class D: C {
    var d: Int
    init(a: Int, b: Int, c: Int, d: Int){
        //派生类引入的属性进行初始化
        print("类D的第一阶段初始化开始")
        self.d = d
        //父类的指定构造方法对父类的属性进行初始化
        /*
         (1) 不可以访问父类中的属性
         (2)不可以调用成员方法
        */
        super.init(a: a, b: b, c: c)
        test()
        print("类D的第二阶段初始化开始")
        if(d>1000){
            self.a = 1000
            self.b = 1000
            self.c = 1000
        }
    }
    convenience init() {
        self.init(a: 9, b: 0, c: 0, d: 0)
        a = 9
        b = 9
        c = 10
        d = 10
    }
    func test() {
        
    }
}
var d = D(a: 0, b: 0, c: 0, d: 0)
/*
 （6）重写指定构造方法
 是指“子类中构造方法与父类中的构造方法的参数列表一模一样”
 在派生类中重写父类的指定构造方法（只能是指定构造方法，不能是便利构造方法）时，，不管重写成指定构造方法还是重写成便利构造方法，都要加上override
 */
/*
 （7）重写便利构造方法：不可以
 在子类中出现的和父类中便利构造方法相同的便利构造方法，并不是对父类中便利构造方法的重写。
 便利构造方法在子类中不能通过任何途径访问
 */
class Human{
    let name: String
    var age: Int
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
    convenience init() {
        self.init(name: "", age: 0)
    }
}
class Woman: Human {
    var haveBaby: Bool = false
    //派生类中定义一个构造方法，它跟父类中的某个指定构造方法一样
    override init(name: String, age: Int){
        haveBaby = false
        super.init(name: name, age: age)
    }
    init(name: String, age: Int, haveBaby: Bool) {
        self.haveBaby = haveBaby
        super.init(name: name, age: age)
    }
//    convenience override init(name: String,age: Int) {
//        self.init(name: name, age: age, haveBaby: false)
//    }
//    加上override关键字，报错
//    convenience init() {
//        self.init(name: "", age: 0, haveBaby: false)
//    }

    convenience init() {
        self.init(name: "", age: 0, haveBaby: false)
    }
}
var w0 = Woman()

/*
 （8）构造器的自动继承
 a.如果子类中没有定义任何的构造方法，且子类中所有的存储属性都有默认缺省值，会自动继承父类中所有的构造方法（包括便利构造方法）
 b.如果子类中只是重写了父类中的某些（而不是全部）指定构造方法，不管子类中的存储属性是否有缺省值，都不会继承父类中的其他构造方法。
 c.如果子类中重写了父类中所有的指定构造方法，不管子类中的存储属性是否有缺省值，都同时会继承父类中所有的便利构造方法。
 */
class XY {
    var x: Int
    var y: Int
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    init(x: Int) {
        self.x = x
        self.y = 0
    }
    convenience init() {
        self.init(x: 0, y: 0)
    }
}
class XYZ: XY {
    var z: Int = 0
//    init(z: Int){
//        self.z = z
//        super.init(x: 0, y: 0)
//    }
    
     override init(x: Int, y: Int) {
     z = 10
     super.init(x: x, y: y)
     }
    
    
     override init(x: Int) {
     z = 10
     super.init(x: x, y: 0)
     }
    
}
var t0 = XYZ()
var t1 = XYZ(x: 0)
var t2 = XYZ(x: 0, y: 0)
print(t0.x)
print(t1.x)
print(t2.x)
/*
 （9）必须构造器:构造方法所属的后续子类必须也得实现这个构造方法
 */
class Some {
    var some: Int
    required init() {
        some = 0
    }
}
class ChildOfSome: Some {
    var sub: Int
    init(sub: Int){
        self.sub = sub
        super.init()
    }
//    required override init() {
    required init() {
        sub = 0
        super.init()
    }
}

class GrandsonOfSome: ChildOfSome {
    var z: Int
    init(z: Int) {
        self.z = z
        super.init(sub: 0)
    }
    
    required init() {
        self.z = 0
        super.init()
    }
}
