//
//  main.swift
//  Lesson2Project
//
//  Created by SrearAlex on 2016/12/12.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//
/*
 本堂课内容：
 （1）swift字符和字符串
 （2）构造字符串
 （3）字符串比较
 （4）数值运算
 （5）赋值运算
 （6）关系运算
 （7）逻辑运算
 （8）区间运算
 */
import Foundation

print("Hello, World!")
/*
 编程是 数据加上数据的处理
 字符信息+字符信息的处理
 char a = 'a' C ASCII标准,不支持中文等
 swift 兼容Unicode标准
 "hello"
 C语言中，中文必须\0结尾
 const char *p = “hello”
 char array[] = "hello"
 */
let c:Character = "a"
var c1:Character
c1 = "张"
/*
 swift中\0不再是字符串的标准
 转义特殊字符 \0(空字符)， \\(反斜杠)， 、\t(水平制表符)， \n（换行符），\r(回车符)， \"（双引号），\'(单引号)
 任意的Unicode标量，写作、写作\u{n},里面的n是一个1——8个与合法Unicode码位相等的16进制数字
 */
var b = "aas\0df张\u{0001F496}"
print(b)
/*
 扩展字符集群
 每一个Swift的character类型实例都表示了一单一的扩展字形集群。扩展字形集群是一个或者多个有序的Unicode标量（当组合起来时）产生的单个人类可读字符
 例如é以单个Unicode标量é或者U+00E9表示，，也可以用一对标量——一个标准字母e（U+0065）以及（U+0301）表示，标量会以图形方式应用到它前边的标量上,当Unicode文本渲染时，就会把e转会位é来输出
 */
let eAcute: Character = "\u{E9}"
let combineEAcute: Character = "\u{65}\u{301}"
print(eAcute, combineEAcute)

/*扩展字形集群是一种非常灵活的把各种复杂脚本字符作为单一 Character值来表示的方法。比如说韩文字母中的音节能被表示为复合和分解序列两种。这两种表示在 Swift 中都完全合格于单一 Character值：
*/
let precomposed: Character = "\u{D55C}" // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}" // ᄒ, ᅡ, ᆫ
// precomposed is 한, decomposed is 한

/*
扩展字形集群允许封闭标记的标量 (比如 COMBINING ENCLOSING CIRCLE, 或者说 U+20DD) 作为单一 Character值来圈住其他 Unicode 标量：
*/
let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute is é⃝
/*区域指示符号的 Unicode 标量可以成对组合来成为单一的 Character值，比如说这个 REGIONAL INDICATOR SYMBOL LETTER U ( U+1F1FA)和 REGIONAL INDICATOR SYMBOL LETTER S  ( U+1F1F8)：
*/

let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
print("\u{1F1FA}", "\u{1F1F8}")
//🇺 🇸

print(regionalIndicatorForUS)
// regionalIndicatorForUS is 🇺🇸

//返回字符串中元素个数
var d = "asdf张"
print(d.characters.count)
var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")
word += "\u{301}"
print("the number of characters in \(word) is \(word.characters.count)")
/*
 字符串的构造
 字符串可以通过+拼接，不能通过-改变
 */
let str1 = "hello"
let str2 = "world"
let str = str1 + str2
print(str)
var index = 9
var urlhead = "http://www.mobiletrain.org"
let message = "\(urlhead)/pic/\(index).png"
print(message)

/*
 字符串的比较
 */
if str1 == "hello" {
    print(str1)
}
if str1 > "aello" {
    print(str1)
}
let str3 = "apple"
//前缀
if str3.hasPrefix("le") {
    print(str3)
}
//后缀
if str3.hasSuffix("le") {
    print(str3)
}
//所有字母转换为大写
print(str3.uppercased())
//首字母大写
print(str3.capitalized)
//所有字母转换为小写
let str4 = "APPLE"
print(str4.lowercased())
//转换字符串大小写，并实现本地化 暂不了解
print(str3.localizedUppercase)
print(str3.localizedCapitalized)
print(str4.localizedLowercase)
//转换字符串大小写，并设置语言环境,暂不理解
var l = Locale.current
print(str3.lowercased(with: l))
print(str3.capitalized(with: l))
print(str4.lowercased(with: l))

//
let str5 = "255"
//swift 3不支持 let e = str5.toInt()
let e: Int! = Int(str5)
print(e)

/*
 数学运算 逻辑运算
 + - * ／ % ++ --
 */
var v = (3+5)*3
let f = v * 3
//let v1: UInt8 = 255+3编译期报错
let v1: UInt8 = 255
let f1: UInt8 = 100
//let x = v1 + f1
//print(x)编译通过，但运行报错，溢出
print(10/3.0)
/*
 取余不再支持浮点数
 */
var quotient = -9 / 2
var remainder = 9 % 2
print("-9 divided by 2 equals to \(quotient), remainder is \(remainder)")
//非true为false，非false为true
print(!true)
//三目运算
print(true ? 0 : 1)
/*
 合并空值运算符（a??b),如果a有值则展开，如果没有值，是nil，则返回默认值b，表达式a必须是一个可选类型，表达式b必须与a的储存类型相同
 合并空值运算符是下边代码的缩写 a != nil ? a! = b
 */
let defaultColor = "red"
var userDefinedColor: String? = "green"
var colorToUse = userDefinedColor ?? defaultColor
print("The colorToUse is \(colorToUse)")//The colorToUse is green
var userDefinedColor2: String?
colorToUse = userDefinedColor2 ?? defaultColor
print("The colorToUse is \(colorToUse)")//The colorToUse is red

//改变数字值的正负号
let three = 3
let minusThree = -three
let plusThree = -minusThree
print(minusThree)
print(plusThree)
//组合赋值符号+=,-=,swift 3中剔除自增自减--，++
v+=2
print(v)
/*
 比较运算符(关系运算符)两侧可以放表达式
 相等(==)
 不相等（!=)
 大于（>)
 小于(<)
 大于等于(>=)
 小于等于(<=)
 等价运算符（===,!==)，判断两个对象的引用是否相同
 */
if str2 == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(str2), but I don't rocognize you")
}
/*
 可以比较两个拥有同样数量值的元组，只要元组中的每一个值都是可以比较的（Int，String），Bool不能比较，意味着包含布尔值的元组不能比较大小
 元组比较大小时比较首个值的大小如果首个为真后面不比较直接为真？，等于比较时，比较每个值是否相等
 此外元组比较运算符仅支持小于七个元素的元组，要比较拥有七个或者更多的元素的元组，必须自己实现运算符
 */
print((2, 2, 2, 2, 2, 2)<(2, 2, 2, 2, 2, 3))
/*
 区间运算符
 闭区间运算符( a...b )定义了从a到b的一组范围，并且包含a和b。a的值不能大于b
 在遍历需要用到的所有数字时，闭区间运算符是个不错的选择，比如在 for-in 循环当中：
 */
for index in 1 ... 5 {
    print("\(index) times 5 is \(index * 5)")
}
/*
 半开区间运算符(a ..< b)定义了从a 到 b的区间，即半开，因为它只包含起始值，但并不包含结束值(左闭右开区间。)如同闭区间运算符， a的值也不能 大于 b，如果a 与b 的值相等，那返回的区间为空
 */
let names = ["Anna", "Alex", "Brain", "Jack"]
let count = names.count
for i in 0 ..< count {
    print("Person \(i+1) is called \(names[i])")
}
/*
 逻辑运算符
 非(!a)
 与(a&&b),两个表达式都为true，整个表达式的值为真，如果任意一个值为false，那么整个表达式为false，如果第一个表达式为false，那么第二个表达式的值会被忽略，短路运算
 或(a||b)，任意一个表达式为true，那么整个表达式为true，如果第一个表达式为true，那么第二个表达式的值会被忽略
 */
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
let hasDoorKey = false
let knowsOverridePassWord = true
if hasDoorKey || knowsOverridePassWord {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
/*
 混合逻辑运算，组合多个逻辑运算符来创建一个更长的组合表达式
 &&和||是左相关的，意味着多个逻辑运算符，会首先计算最左边的表达式
 */
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassWord {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
/*
 显式括号，虽然不被要求，但是使用能使复杂的表达式更容易阅读
 */
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassWord {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

/*
 赋值运算：= += -= *= ／= %=
 不允许连环赋值
 */
var b3 = 8
var c3 = 9
var d3: Int = 10
d3 += 3
//c3 = d3 = 9编译不通过
