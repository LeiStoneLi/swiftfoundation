//
//  main.swift
//  MemoryManagement
//
//  Created by SrearAlex on 2016/12/30.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//
/*
    Swift 内存管理
 */
import Foundation

/*
 (1)析构方法
 对象的内存被回收前夕被隐式调用的方法。主要执行一些额外的操作。
 比如：关闭文件，断开网络、释放对象持有的一些资源等。
 OC中：dealloc，MRC [obj release]
 ARC,弱化内存操作（Swift的析构方法，不用去管理内存）
 对象的生命周期
 */
class FileHandle {
    var fd: Int32?//文件描述符
    init(path: String) {
        var ret = open(path, O_RDONLY)
        if (ret == -1) {
            fd = nil
        } else {
            fd = ret
        }
    }
    deinit {
        if let ofd = fd {
            close(ofd)
        }
        print("对象被销毁，持有资源被释放。")
    }
}
//对象（引用类型）何时被销毁，对象没有任何引用的时候。
var ofh: FileHandle? = FileHandle(path: "/etc/passwd")
ofh = nil //目前没有任何的引用指向刚刚构造的对象。
/*
 （2）析构方法的自动继承——父类的析构方法会被自动调用，不需要子类管理
 */
class SomeClass {
    deinit {
        print("SomeClass deinit!")
    }
}
class SubOfClass: SomeClass {
    deinit {
        print("SubOfClass deinit!")
    }
}
var osub: SubOfClass? = SubOfClass()
osub = nil

/*
 (3)Swift语言的内存管理分析
 * 内存管理的对象——引用类型的对象（class类型）
 * 内存管理的原则：当没有任何指向某个对象的时候，系统会自动销毁该对象。
 * 如何做到该原则：通过ARC技术。自动引用计数
 */
class MemArc {
    deinit {
        print("Deinit!")
    }
}
var t0 = MemArc()
var t1 = t0
var t2 = MemArc()

//t0、t1跟t2指向同一个对象
t0 = t2
t1 = t2
/*
 (4)weak引用（弱引用）
 */
/*
 (5)unowned引用（弱引用）
 */
class Ref {
    deinit {
        print("Ref deinit!")
    }
    func test() {
        print("Test")
    }
}
//强引用，默认的引用方式
var strongRef = Ref() //1
var strongRef1 = strongRef //2
//弱引用,weak引用非常安全的引用方式
//弱引用，是一个可选类型
weak var weakRef = Ref() //ARC
weak var weakRef1: Ref? = strongRef//ARC
//weakRef!.test()
if let wr = weakRef {
    wr.test()
}
//弱引用
//不是可选类型
//不安全。慎重使用unowned关键字
unowned var unownedRef = Ref()//无主引用
//unownedRef.test()

/*
 (6)循环强引用
 ARC不是万能的，它可以很好的解决内存过早释放的问题，但是在某些场合下不能很好的解决内存泄漏的问题。
 */
class Person {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being denitialized")
    }
}
class Apartment {
    let number: Int
    init(number: Int) {
        self.number = number
    }
    var tenant :Person?
    deinit {
        print("Apartment #\(number) is being deinitialized")
    }
    
}

var john: Person?
var number73: Apartment?

john = Person(name: "John")
number73 = Apartment(number: 73)

john!.apartment = number73
number73!.tenant = john

//两个对象没有被销毁，但是我们没有办法在访问它们了，内存泄漏
john = nil
number73 = nil


//将某个强引用改为弱引用来解决循环强引用带来的内存泄漏问题
class Person1 {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment1?
    deinit {
        print("\(name) is being denitialized")
    }
}
class Apartment1 {
    let number: Int
    init(number: Int) {
        self.number = number
    }
    weak var tenant :Person1?
    deinit {
        print("Apartment #\(number) is being deinitialized")
    }
    
}
var jack: Person1?
var number74: Apartment1?

jack = Person1(name: "John")
number74 = Apartment1(number: 74)

jack!.apartment = number74
number74!.tenant = jack

jack = nil
number74 = nil

/*
 (7)unowned解决循环强引用
 */
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("card \(number) is being deinitialized")
    }
}
var lisa: Customer?
lisa = Customer(name: "Lisa Bush")
lisa!.card = CreditCard(number: 1234_5678_9012_3456, customer: lisa!)
lisa = nil
