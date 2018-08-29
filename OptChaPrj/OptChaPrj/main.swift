//
//  main.swift
//  OptChaPrj
//
//  Created by SrearAlex on 2017/1/3.
//  Copyright © 2017年 SrearAlex. All rights reserved.
//

import Foundation

/*
 可选链——Optional Chaining
 */

/*
 （1）深入研究可选类型
 */
//有值，没有值nil。可选类型有两种状态。
var opa: Int? = 9
var opb: Optional<Int>

//基本类型的变量，必须在使用之前先进行初始化
//安全！！！，因为不管我们在什么时候访问某个普通变量，它都是有意义的。
//普通变量的状态，只有一种：有值
//var a: Int
//a = 10
print(opa)
print(opb)
//print(a)

//基本类型变量的局限性，又制造了可选类型。

//可选类型是安全的吗？
//安全，因为解包前会进行可选绑包

if let oc = opa {
    print(oc)
}

var data: NSData? = NSData(contentsOfFile: "/etc1/passwd")
print(data)
/*
 可选链介绍
 */
class Person {
    var name = ""
    func whoami() -> String {
        print("My name is \(name)")
        return name
    }
    init(name: String) {
        self.name = name
    }
}
var p0: Person?
var p1: Person = Person(name: "Tom")
p1.name = "zhangsan"
p1.whoami()
//通过可选类型来调用相应的属性或者方法等
//p0!.name = "Lisi"
//p0!.whoami()
//隐式解包
if let t: Person = p0 {
    t.whoami()
    t.name = "Lisi"
}
if p0 != nil {
    p0!.name = "Lisi"
    p0!.whoami()
}
//可选链的方式
p0 = p1
p0?.name = "Lisi"
p0?.whoami()

//通过可选链调用取得的返回值会被包装成一个可选类型的数据
//可选链有可能会失效（nil），也有可能会成功（返回值也会被包装成可选值）
let t: String? = p0?.name
let t1: String = p0!.name
print(p0?.name)
print(p0!.name)
print(p0?.whoami())

/*
 （4）通过可选链调用下标索引
 */

//可选值?.属性
//可选值?.方法
//如何调用下标方法呢？: 可选值?[参数]
class MyStringHash {
    subscript (x: String) -> Int {
        return x.hashValue - 1000
    }
}
var msh = MyStringHash()
var mshop: MyStringHash?
mshop = msh
print(msh["abc"])
print(mshop?["abc"])

var array: [Int]? = [1,2,3,4,5]
print(array?[0])

/*
 （5）可选链的赋值操作
 */
/*
class Person {
    var name = ""
    func whoami() -> String {
        print("My name is \(name)")
        return name
    }
    init(name: String) {
        self.name = name
    }
}
 */
var person0: Person?
var person1: Person = Person(name: "Tom")
person0 = person1
person0?.name = "Lisi"
print(person1.name)

//判断赋值操作是否成功
let res: Void? = person0?.name = "Lisi"
print(res)
if (person0?.name = "Lisi") != nil {
    print("成功")
}

/*
 (7)多层链接的可选链
 单层链接：a?.属性
 多层链接：d.c?.b.a?.tag
 */
class A {
    var tag: String = ""
}
class B {
    var a: A?
}
class C {
    var b: B = B()
}
class D {
    var c: C?
}
var d = D()
var c = C()
var a = A()
a.tag = "1000phone"
d.c = c
d.c?.b.a = a//可选链

print(d.c?.b.a?.tag)
