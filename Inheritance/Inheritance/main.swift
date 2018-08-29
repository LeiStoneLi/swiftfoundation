//
//  main.swift
//  Inheritance
//
//  Created by SrearAlex on 2016/12/29.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//

import Foundation

/*
 （1）继承语法
 （2）方法重写
 （3）继承的super关键字
 （4）重写属性
 （5）重写属性的限制
 （6）重写属性观察器
 （7）重写属性观察器的限制
 （8）如何防止重写
 */
/*
 （1）继承语法
 继承是面向对象最显著的一个特征。继承是从已有的类中派生出新的类，新的类能够从已有的类中派生出新的类，新的类能吸收已有类的数据属性和行为，并能扩展新的能力。
 术语：基类（父类，超类），派生类（子类，继承类）
 swift继承的语法： 
 class ChildClass: FatherClass{
 }
 继承优点：代码重用。
 继承缺点：增加程序的耦合度，父类的改变会影响子类
 swift没有多继承
 */
/*
 （2）super关键字
 派生类中方法实现中，可以通过super关键字来引用基类的属性和方法
 super是个编译器符号，告诉编译器从调用的位置当前类的父类中查找
 */
/*
 (3)方法重写（override）
 */
class Human {
    var name: String = ""
    var id: Int = 0
    func eat() {
        print("eat")
    }
    func drink() {
        print("drink")
    }
    func sleep() {
        print("sleep")
    }
}
class Woman: Human {
    func birth() {
        print("birth")
    }
    //如果重写方法，需要在最前面加上override关键字
    override func eat(){
        super.eat()
        print("\(name) eat!")
    }
    //派生类中使用基类的方法或者属性
    func eatAndSleep() {
        eat()
        super.eat()//查找从父类开始
        super.sleep()
        birth()
    }
}
let w = Woman()
w.name = "Lisa"
w.id = 893233
let h = Human()
//通过子类的对象调用方法，优先使用本类中的重写方法
w.eatAndSleep()
w.eat()
w.drink()
w.sleep()
w.birth()
h.drink()
h.eat()
h.sleep()
/*
 重写属性
 */
/*
 （5）属性重写的限制
 1.属性重写的时候只有set方法，没有get方法是否可以：不可以
 2.只读的计算(／存储)属性是否在重写的时候变成读写计算属性（权力变大）：可以 升权
 3.可读写的计算／存储属性是否可以重写为只读的计算属性（权力变小）：不可以
 */

class Father {
    var storeProperty: Int = 0//存储属性
    var computeProperty: Int {//计算属性
        get{
            return 0
        }
//        set {
//            print("In Father class: set \(newValue) ")
//        }
    }
}
class Child: Father {
    //可以将一个父类的存储属性重写成计算属性，不可以将存储属性又重写成存储属性
    override var storeProperty: Int {
        get{
            return 10
        }
        set {
            print("In Child class: set storeProperty \(newValue) ")
        }
    }
    //可以将父类中的计算属性重写，重写的样式也是计算属性样式
    override var computeProperty: Int {//计算属性
        get{
            return 10
        }
        set {
            print("In Child class: set coputeProperty \(newValue) ")
        }
    }
}
let ch = Child()
//通过子类的对象来调用重写后的属性或者方法，肯定会调用子类中的子类中的重写版本
ch.storeProperty = 100
/*
 (6)重写属性观察器
 1.只能给非lazy属性的变量存储属性设定属性观察器，不能给计算属性设定属性观察器
 属性观察器的限制：
 不可以给只读的存储／计算属性，在子类中设定属性观察器
 */

class Observer {
    var storeProperty: Int = 0 {
        willSet {
            
        }
        didSet {
            
        }
    }
    var computeProperty:Int {
        get {
            return 0
        }
        set {
            print("Do nothing!")
        }
    }
}
class ChildOfObserver: Observer {
    //可以重写父类中变量存储属性的属性观察器
    override var storeProperty: Int {
        willSet {
            print("will set")
        }
        didSet {
            print("did set")
        }
    }
    //可以重写父类中的计算属性的属性观察器
    override var computeProperty:Int {
        willSet {
            print("computeProperty will set")
        }
        didSet {
            print("computeProperty did set")
        }
    }
}
var child = ChildOfObserver()
child.storeProperty = 10
child.computeProperty = 10
/*
 (7)防止重写（override）
 添加final 关键字
 与override冲突，防止重写属性，方法，属性观察器。
 final关键字修饰类的话，表示这个类不可以被继承。
 如果修饰属性或者方法，表示方法不可以被重写
 */
