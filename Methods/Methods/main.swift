//
//  main.swift
//  Methods
//
//  Created by SrearAlex on 2016/12/28.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//

import Foundation

/*
    方法
 （1）实例方法
 （2）方法的参数名称
 （3）实例方法中隐藏的self
 （4）mutating方法
 （5）类方法
 （6）下标脚本语法
 （7）单索引值下标脚本
 （8）多索引值下标脚本
 */
class MyPoint {
    var _x: Double = 0.0
    var _y: Double = 0.0
    func setX(x: Double, y: Double) {
//      _x = x
//      _y = y
        self._x = x
        self._y = y

    }
    func show() {
        print("x=\(_x),y=\(_y)")
    }
}
var p0 = MyPoint()
var p1 = MyPoint()
p0.setX(x: 10.0, y: 10.0)//p0 == self
p1.setX(x: 10, y: 10)//p1 == self
p0.show()
/*
 (2)方法的参数名称
 */
func setX(x: Double, y: Double) {
    var _x: Double
    var _y: Double
    _x = x
    _y = y
}
/*
 (4)mutating方法
 值类型（结构体或者枚举）默认方法是不可以修改属性的，如果要修改需要 做特殊处理
 */
class MyPerson {
    var name: String = ""
    var age: Int = 0
    func set(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    func show() {
        print("name=\(name), age=\(age)")
    }
}
var m0 = MyPerson()
m0.set(name: "zhangsan", age: 10)
m0.show()
/*
 值类型的结构体 枚举 ，修改属性，需要加mutating修饰
 */
struct MyStruct {
    var name: String = ""
    var age: Int = 0
    mutating func set(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    func show() {
        print("name=\(name), age=\(age)")
    }

}
let myStruct = MyStruct()
//myStruct.set(name: "zhangsan", age: 10) 结构体类型的常量实例，不能修改属性值，所以不能调用
myStruct.show()

enum LightSwitch {
    case OFF, LOW, HIGH
    mutating func next() {
        switch self {
        case .OFF:
            self = .LOW
        case .LOW:
            self = .HIGH
        case .HIGH:
            self = .OFF
        }
    }
}
var light = LightSwitch.OFF
light.next()//light == .LOW

/*
 (5)类型方法
 通过类名来调用的方法，就像类型属性一样
 通过在func关键字之前使用static关键字来明确一个类型方法。类同样可以使用class关键字来允许子类重写父类对类型方法的实现
 在OC中，只能在类中定义类级别的方法，但是在swift中，可以在所有的类里定义类级别的方法，包括结构体和枚举。每一个类方法都能够对它自身的类范围显示生效
 类方法里面不存在self
 */
struct TypeMethods {
    var p: Int = 0
    static var sp: Int = 0
    func method() {
        print("p=\(p),sp=\(TypeMethods.sp)")
    }
    static func staticMethod() {
        print("sp=\(TypeMethods.sp)")
    }
}
var tm = TypeMethods()
tm.method()
TypeMethods.staticMethod()

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {highestUnlockedLevel = level}
    }
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func comlete(level: Int){
        LevelTracker.unlock(level+1)
        tracker.advance(to: level+1)
    }
    init(name: String){
        playerName = name
    }
}
var player = Player(name: "Argyrios")
player.comlete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}

/*
 (6)subscripts(下标)——访问对象中数据的快捷方式
 所谓下标脚本语法就是能够通过 实例[索引值]来防伪实例中的数据
 subscript (index: Int) -> T //array
 subscript(key: Key) -> Value? //dict
 dict[key]
 dict.subscript(key)
 array[10]
 array.subscript(10)
 */
let array: Array<Int> = [1, 2, 3, 4, 5]
print(array[1])//实例对象[索引]，subscripts
let dict: Dictionary<String, Int> = ["1": 1]//key: value， key hash
print(dict["1"] ?? 0)

/*
 (7)subscript方法实现
 自己定义的类的下标实现
 */
struct Student {
    var name: String = ""
    var math: Int = 0
    var chinese: Int = 0
    var english: Int = 0
    func scoreOf(course: String) -> Int? {
        switch course {
        case "math":
            return math
        case "chinese":
            return chinese
        case "english":
            return english
        default:
            return nil
        }
    }
    subscript (course: String) -> Int? {
        get{
            switch course {
                case "math":
                    return math
                case "chinese":
                    return chinese
                case "english":
                    return english
                default:
                    return nil
            }
        }
        set {
            switch course {
            case "math":
                math = newValue!
            case "chinese":
                chinese = newValue!
            case "english":
                english = newValue!
            default:
                print("key wrong")
            }
        }
    }
    
}
var xiaoli: Student = Student(name: "lisi", math: 98, chinese: 92, english: 95)
print(xiaoli.scoreOf(course: "math") ?? 0)
print(xiaoli["math"]!)
xiaoli["math"] = 100
print(xiaoli["math"]!)
/*
 (8)多索引subscript
 */
struct Mul {
    subscript(a: Int, b: Int) -> Int {
        return a*b
    }
}
var mul = Mul()
print(mul[3,9])
