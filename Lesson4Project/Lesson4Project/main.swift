//
//  main.swift
//  Lesson4Project
//
//  Created by SrearAlex on 2016/12/14.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//
/*
                Swift语言控制流
 三种基本结构：a 顺序执行 b 选择执行 c 循环执行
 （1）选择执行（基于if）
 （2）循环执行
 （3）选择执行（基于switch）
 */
import Foundation
//（1）基于if语句的选择执行
// if 条件{指令}
let a: Int = 10
let b: Int = 19
var value: Int
value = a
if b > a {
    value = b
}
//if 条件 {指令} else {指令}
if a > b {
    value = a
} else {
    value = b
}
//多分支
var score: Double = 98.5
var res: String
if score >= 90 {
    res = "优秀"
} else if score >= 80 {
    res = "良好"
} else if score >= 60 {
    res = "及格"
} else if score >= 0 {
    res = "不及格"
}
//(3)while循环 while 循环保持条件 {循环执行语句}
var i: Int = 1
var sum: Int = 0
while i <= 10 {
    sum += i
    i += 1
}
print(sum)
sum = 0
i = 1
repeat {
   sum += i
    i += 1
} while i <= 10
print(sum)
//swift 3 中不再支持
//(4) for循环 for 循环初始化语句; 条件; 递增语句 {循环语句}
//var sum2 = 0
//for var i = 1; i <= 10; i += 1 {
//    sum2 += i
//}
//print(sum2)
//(5) for-in循环 for
sum = 0
for k in 1 ... 10 {
    sum += k
}
print(sum)

for a in [1, 2, 3, 4, 5] {
    print(a)
}
for a in [1: "1", 2: "2"] {
    print(a)
}
for (a, b) in [1: "1", 2: "2"] {
    print("\(a): \(b)")
}
//swift 3 不支持
//for a in "helloworld" {
//    print(a)
//}
for a in "hello world".unicodeScalars {
    print(a)
}

//（6）循环控制中的转移语句break和continue
//break 退出整个循环 continue 退出本次循环
var array = [3, 5, 6, 7, 9, 8, 10]
var flag = false
for (index, value) in array.enumerated() {
    if value % 5 == 0 {
        print(index)
        flag = true
        break
    }
}
if flag == false {
    print("Not Found")
}
 var cnt = 0
for a in array {
//    if a % 2 != 0 {
//        continue
//    }
//    cnt += 1
    if a % 2 == 0 {
        cnt += 1
    }
}
print(cnt)
//（7）switch语句
//一个值与多个可能的模式匹配
//不用书写break，必须书写default，支持多匹配，要写在同一个case中，中间用 , 隔开
let  str = "aAbBacdef"
var cntA = 0, cntB = 0, cntOther = 0
for c in str.unicodeScalars {
    switch c {
    case "a":
        cntA += 1
    case "b":
        cntB += 1
    default:
        cntOther += 1
    }
}
print(cntA)
print(cntB)
print(cntOther)
//(8)switch广义的匹配
let x = 1000
switch x {
case 1 ... 9:
    print("个位数")
case 10 ... 90:
    print("十位数")
case 100 ... 999:
    print("百位数")
case 1000 ... 9999:
    print("千位数")
default:
    print("不符合")
}
let point = (-10, 10)
switch point {
case (0,0):
    print("坐标原点")
case (1 ... 10,1 ... 10):
    print("x和y坐标范围位于1——10之间")
case (_,0):
    print("点在x轴上")
default:
    print("其他")
}
//（9）Value Bindings 值绑定模式
switch point {
//case (let x, let y):
//    print("\(x):\(y)")
case let (x, y) where x == -y:
    print("\(x):\(y)")
case (let x, 10):
    print(x)
default:
//    print("其他")
    break
}
/*
 控制转移语句
 控制转移语句在代码执行期间改变代码的执行顺序，通过从一段代码转移控制到另一段，Swift拥有物种控制转移语句：
 continue
 break
 fallthrough
 return
 throw
 */
//continue
//break 除了循环中使用，还可以运用在switch中，default中

/*
 fallthrough
 使用fallthrough关键字，使得贯穿到下一个情况中,但是不会为switch贯穿入情况的条件做情况检查，会直接执行下一种情况中的代码，并不会做匹配
 */
let integerToDescribe = 10
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
//case 2, 3, 5, 7, 9, 11, 13, 17, 19:
//    description += " a prime number, and also"
//    fallthrough
case var i where i % 5 == 0:
    description += " a multiple of 5, and also"
    fallthrough
case 2, 3, 5, 7, 9, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer"
}
print(description)

//guard语句， 类似于if语句，基于布尔值表达式来执行语句。使用guard语句来要求一个条件必须是真才能执行guard之后的语句。与if语句不同，guard语句总是有一个else分支——else分句里的代码会在条件不为真的时候执行
// 如果条件被满足，代码会执行直到guard语句后的花括号。任何在条件中使用可选项绑定而赋值的变量或者常量在guard所在的代码块中随后的代码里都是可用的。
//如果这个条件没有被满足，那么在else分支里的代码就会被执行，这个分支必须转移控制结束guard所在的代码块，要这么做可以使用控制转移语句return，break，continue，或者throw，或者它可以调用一个不带返回值的函数或者方法
//相对于使用if语句来做同样的事情，为需求使用guard语句来提升代码的稳定性，它会让正常的写代码而不用包裹斤else 代码块，并且它允许保留在需求之后处理危险的需求
func greet(person:[String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)")
    print("Nice to meet you \(name)")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location)")
}
greet(person: ["name": "Jane"])
greet(person: ["name": "Lucy", "location":"Singapore"])
greet(person: ["location": "Beijing"])//无输出，总是因为name为空，执行else中的语句，后面的语句不执行了
