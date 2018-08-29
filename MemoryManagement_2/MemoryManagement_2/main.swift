//
//  main.swift
//  MemoryManagement_2
//
//  Created by SrearAlex on 2016/12/30.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//
/*
        Swift内存管理第二部分（高级）
 （1）深浅拷贝
 （2）字符串拷贝
 （3）集合类的拷贝
 （4）局部临时对象和全局对象
 （5）类型属性的声明周期
 （6）隐式强引用——集合类，timer、元组
 （7）闭包属性引起的循环强引用
 （8）解决（7）的问题
 */
import Foundation

//结构体，值类型
struct Deep {
    var copy: Int = 0
}
//类，引用类型
class Shallow {
    var copy: Int = 0
}

//值类型的赋值操作是深拷贝
var d0 = Deep()
var d1 = d0
d1.copy = 9
print(d0.copy)//0
print(d1.copy)//9

//引用类型的赋值操作是浅拷贝
//引用类型的拷贝是将不同的引用指向同一个对象
var s0 = Shallow()
var s1 = s0
s1.copy = 9

print(s0.copy)
print(s1.copy)

/*
 （2）字符串拷贝
 深拷贝
 */
var swiftStr: String = "Hello"
var swiftStr1 = swiftStr
swiftStr1 += " World"
print(swiftStr)
print(swiftStr1)

//浅拷贝，引用类型
var ocStr = NSMutableString(string: "Hello")
var ocStr1 = ocStr
ocStr1.insert(" World", at: ocStr.length)
print(ocStr)
print(ocStr1)

/*
 (3)集合类的拷贝
 数组，字典
 */
var array: Array<Int> = [1,2,3]
var array1 = array
array1 += [4,5,6]
print(array)
print(array1)

var dict: Dictionary<Int,String> = [1: "a", 2:"b"]
var dict1 = dict
dict1[3] = "c"
print(dict)
print(dict1)

//浅拷贝，引用类型
var ocArray = NSMutableArray(array: array)
var ocArray1 = ocArray

ocArray.add(4)

print(ocArray)
print(ocArray1)

/*
 (4)深入分析集合类的拷贝
 */
//结构体，值类型
//struct Deep {
//    var copy: Int = 0
//}
//类，引用类型
//class Shallow {
//    var copy: Int = 0
//}
var de0 = Deep()
var de1 = Deep()
//数组的元素都是值类型
var dearray = [de0, de1]

var sh0 = Shallow()
var sh1 = Shallow()

//数组的元素都是引用类型
var sharray = [sh0, sh1]

//深拷贝
var dearray1 = dearray
var sharray1 = sharray
//当将数组中的某个元素替换，或者改变了数组的大小，不会影响另外一个数组。
//dearray1.removeLast()
//print(dearray1.count)
//print(dearray.count)
//
//var dearray2 = dearray
//dearray2[0] = Deep(copy: 3)
//print(dearray2[0].copy)
//print(dearray[0].copy)
/*
 (1) 根据被拷贝数组的大小来创建一个新的数组对象，新的容量跟原始数组大小相同
 (2) 将原始数组中的每一个元素依次拷贝到新的数组对象中。
 */
dearray1[0].copy = 88
print(dearray1[0].copy)
print(dearray[0].copy)

sharray1[0].copy = 99
print(sharray1[0].copy)
print(sharray[0].copy)

/*
 (5)隐式强引用
 */
class Student {
    var name: String
    init(name: String) {
        self.name = name
    }
    func show() {
        print("name=\(name)")
    }
    deinit {
        print("\(name) deinit!")
    }
}

//此时，stu0和stu1都引用了同一个对象

var stu0: Student? = Student(name: "Tom")
var stu1 = stu0
stu0 = nil
stu1 = nil

//Student(name: "zhangsan")
//Student(name: "lisi")
//对象加入数组中，对象如果是引用数据类型，那么数组会强引用该对象
//数组让该对象的引用计数加1
var stuarray: [Student]? = [Student(name: "zhangsan"), Student(name: "lisi")]
stuarray![0].name = "zhangsanfeng"
//(1)当某个对象不再属于数组时，该对象的引用计数会减1
//(2)数组本身被销毁的时候，它包含的所有对象不再属于它，因此如果对象是引用数据类型，它的计数将会减1
//stuarray.remove(at: 0)
stuarray = nil

/*
 (6)局部和全局引用
 */
//1.作用域。2.生命周期
//作用域：从它声明开始，到离它最近的大括号结束时结束
//局部引用定义在代码块中
let ref: Int = Int(8)//全局引用
if true {
    if true {
        var ref: Student = Student(name: "zhangsan")
        ref.name = "Zhangsan"
    }
    //ref.name = "zhangsan"
}

func localFunc() {
    var ref: Student = Student(name: "lisi")
}
localFunc()

//全局引用，作用域：定义的位置开始到文件的结尾处。
//在之后执行访问它
func testFunc1() {
    gloabal_ref = 10
}
//gloabal_ref = 10//执行语句
//testFunc1()//不可以，方法
//生命周期：跟当前程序的生命周期相同
var gloabal_ref: Int = Int(8)
gloabal_ref = 10//执行语句

func testFunc() {
    gloabal_ref = 10
}
testFunc()
//尽量在方法函数中使用局部引用
var global_stu = Student(name: "zhansan")

func test() {
    var global_stu = Student(name: "zhansan")
}
//test()

/*
 （7）闭包属性引起的循环强引用
 */
/*
 解决闭包引起的循环强引用
 */
class CycleRef {
    var a: Int = 9
    //如果闭包属性中，没有直接或者间接访问self，就不会产生循环强引用
    lazy var closure: () -> Void = {
        //默认闭包会对它访问的对象执行强引用
//        [unowned self] in
        [weak self] in
        print("a=\(self!.a)")
    }
    deinit {
        print("deinit")
    }
}

//两个对象，闭包对象，cr指向的对象。
//前提：闭包或者函数时引用数据类型。
var cr: CycleRef? = CycleRef()//引用计数： +1
cr!.closure()//引用计数： +1 or +2 ... +n
cr = nil //-1

