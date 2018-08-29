//
//  main.swift
//  Property
//
//  Created by SrearAlex on 2016/12/21.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//

import Foundation

/*
        属性
 （1）存储属性
 （2）常量属性
 （3）结构体常量
 （4）延迟存储属性
 （5）计算属性
 （6）只读计算属性
 （7）swift的kvo
 （8）类属性
 */
//(1)存储属性
struct Person {
    var name: String
    var age: Int
}
var person = Person(name: "zhangsan", age: 10)
person.name = "lisi"
person.age = 10

class Person2 {
    var name: String = "zhangsan"
    var age: Int = 10
}
var person2 = Person2()
person.name = "lisi"
person.age = 10

//(2)常量存储属性
class Male {
    let gender: String = "男"
    var name: String = "zhangsan"
    var age: Int = 10
}
var male = Male()
//male.gender = "女"
male.name = "lisi"
male.age = 10
struct Male2 {
    let gender: String = "男"
    var name: String = "zhangsan"
    var age: Int = 10
}

//（3）结构体常量或者类常量与存储属性
/*
 结构体常量对象，它本身是一个常量，其次其对应的对象不可以被修改
 类常量对象，它本身是一个常量，其次它对应的对象，可以通过它来进行修改
 结构体或者枚举：值   类：引用
 */
let m = Male()
//m.gender = "女"
m.age = 11

let m2 = Male2()
//m2.gender = "女"
//m2.age = 11

/*
 (4)延迟存储属性
 Swift语言中所有的存储属性必须有初始值，也就是当构造完一个类或者结构体的对象后，对象中所有的存储属性必须有初始值，但是也有例外，其中延迟存储属性可以将属性的初始化向后推迟到该属性第一次被调用的时候。
 1.属性不适合一开始就初始化，取决于外部的很多因素
 2.属性有可能我们从来不用，但是它的初始化又需要很长的时间
 */
struct MyStudent {
    var name: String
    var chinese: Double
    var math: Double
    func showMyself() {
        print("姓名：\(name),语文成绩：\(chinese),数学成绩:\(math)")
    }
}
class MyClass {
    var members: [MyStudent] = []
    //班级里面所有学生的平均成绩
    //只提供了get方法的计算属性，称之为只读计算属性
    var average: Double {
        get {
            var t: Double = 0
            for i in members {
                t += i.chinese
                t += i.math
            }
            if members.count > 0 {
                return t / Double(members.count)
            } else {
                return 0
            }
        }
    }
    lazy var averageScore: Double = self.getAverageScore()
    func getAverageScore() -> Double {
        print("Test lazy property")
        var t: Double = 0
        for i in members {
            t += i.math
            t += i.chinese
        }
        if members.count > 0 {
            return t / Double(members.count)
        } else {
            return 0
        }
    }
    func show() {
        for i in members {
            i.showMyself()
        }
    }
}
let s0 = MyStudent(name: "张三", chinese: 85, math: 100)
let s1 = MyStudent(name: "李四", chinese: 89, math: 92)

var c0 = MyClass()
c0.members.append(s0)
c0.members.append(s1)
c0.show()
print(c0.getAverageScore())

print("********************")
print(c0.averageScore)
print(c0.average)
//c0.average = 280只读属性不能使用set方法
/*
 (5)计算属性
 1.swift中的计算属性不直接存储值，跟存储属性不同，没有任何的“后端存储与之对应”。
 2.计算属性用于计算，可以实现setter和getter这两种计算方法。
 3.枚举不可以有存储属性，但是允许有计算属性
 对象.属性=某个值 setter
 let value = 对象.属性 getter
 计算属性只能被声明为var
 */
struct MyRect {
    var origin: (x: Double, y: Double) = (0, 0)
    var size: (w: Double, h: Double)=(0, 0)
    var center: (x: Double, y: Double) {
        get {
            return (origin.x + size.w/2, origin.y + size.h/2)
        }
//        set(n) {
//            //origin是存储属性，可以被赋值
//            //center = n,center是一个计算属性，不可以被赋值
//            origin.x = n.x - size.w/2
//            origin.y = n.y - size.h/2
//        }
        set {
            //origin是存储属性，可以被赋值
            //center = n,center是一个计算属性，不可以被赋值
            origin.x = newValue.x - size.w/2
            origin.y = newValue.y - size.h/2
        }

    }
}
var rect = MyRect()
rect.size = (100, 100)
rect.origin = (0, 0)
print("x=\(rect.center.x),y=\(rect.center.y)")
rect.center = (80,80)
print("x=\(rect.center.x),y=\(rect.center.y)")
print("x=\(rect.origin.x),y=\(rect.origin.y)")
/*
 (6)只读计算属性 readonly
 只提供了get方法的计算属性。称之为只读计算属性
 */

/*
 （7）观察属性的变化，是指属性被修改时可以调用我们事先写好的代码去额外执行一些操作类似于OC中的KVO
 存在两种属性观察期器
 1.willSet 在设置新值之前被调用
 2.didSet 在新值被存储之后被调用
 可以直接为除lazy属性之外的存储属性添加属性观察器，当然也可以在继承类中为父类的计算属性提供属性观察器（以后实现）
 */
struct MyRect2 {
    var origin: (x: Double, y: Double) = (0, 0){
        willSet {
            print("will set\(newValue.x), \(newValue.y)")
        }
        didSet {
            print("did set\(oldValue.x), \(oldValue.y)")
        }
    }
    var size: (w: Double, h: Double)=(0, 0)
    var center: (x: Double, y: Double) {
        get {
            return (origin.x + size.w/2, origin.y + size.h/2)
        }
        //        set(n) {
        //            //origin是存储属性，可以被赋值
        //            //center = n,center是一个计算属性，不可以被赋值
        //            origin.x = n.x - size.w/2
        //            origin.y = n.y - size.h/2
        //        }
        set {
            //origin是存储属性，可以被赋值
            //center = n,center是一个计算属性，不可以被赋值
            origin.x = newValue.x - size.w/2
            origin.y = newValue.y - size.h/2
        }
        
    }
}
var rect2 = MyRect2()
rect2.size = (100, 100)
rect2.origin = (50, 50)
/*
 (8)类型属性
 1.也就是为“类”本身定义属性，这样的属性不隶属于某一个“对象”，可以认为所有的对象公用这个属性
 2.使用static关键字来开一类型属性，对于类类型的计算类型属性，可以使用class关键字来允许子类重写父类的实现。
 对象.属性
 类名称.属性
 */
struct TypeProperty {
    var property: Int = 0
    static var staticProperty: Int = 0
    static var staticComputProperty: Int {
        return TypeProperty.staticProperty
    }
    func test() {
        print("property=\(property),staticProperty=\(TypeProperty.staticProperty)")
    }
}
var object = TypeProperty()
var object1 = TypeProperty()
object.property = 10
object1.property = 20
TypeProperty.staticProperty = 10
object.test()
object1.test()
enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    var property: Int = 0
    static var staticProperty: Int = 0
    static var staticComputProperty: Int {
        get {
            return 10
        }
        set {
            
        }
    }
    class var computedTypeProperty: Int{
        return 107
    }
    func test() {
        print("property=\(property),staticProperty=\(SomeClass.staticComputProperty)")
    }
}
var someClassObject = SomeClass()
SomeClass.staticComputProperty = 10
someClassObject.test()
