//
//  main.swift
//  Closure
//
//  Created by SrearAlex on 2016/12/19.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//
/*
 (1)闭包的概念和分类
 自包含的函数代码块
 全局函数（有名）—— 一个有名字但不会不火任何值的闭包
 闭包表达式（匿名） —— 能捕获上下文中的常量或者变量（是一个轻量级语法所写的可以捕获其上下文中常量或变量值的没有名字的闭包）
 嵌套函数 —— 一个有名字且能从其上层函数捕获值的闭包
 
 常见优化包括：
 利用上下文推断形式参数和返回值的类型
 单表达式的闭包可以隐式返回
 简写实际参数名
 尾随闭包语法
 */
import Foundation


/*
 (2)闭包表达式语法
 {(参数) -> 返回值类型 in
 执行语句
 }
 { (parameters) -> (return type) in
    statements
 }
 */
let sayHello = {
    print("Hello World")
}
sayHello()
let add = {(a: Int, b: Int) -> Int in
    return a + b
}
print(add(3,5))
/*
 (3)闭包表达式回调用法
 */
func showArray(_ array: [Int]) {
    for x in array {
        print("\(x)", terminator: " ")
    }
    print()
}
var array = [20, 2, 3, 70, 8]
showArray(array)
func bubbleSort(array: inout [Int]){
    let cnt = array.count
    for i in 1 ..< cnt {
        for j in 0 ..< cnt-i {
            if(array[j] > array[j+1]){
            let t = array[j]
            array[j] = array[j+1]
            array[j+1] = t
            }
        }
    }
    
}
bubbleSort(array: &array)
showArray(array)

func bubbleSort2(array: inout [Int], cmp:(Int, Int) -> Int) {
    let cnt = array.count
    for i in 1 ..< cnt {
        for j in 0 ..< cnt-i {
            if(cmp(array[j], array[j+1]) == -1) {
                let t = array[j]
                array[j] = array[j+1]
                array[j+1] = t
            }
        }
    }

}
var array2 = [20, 2, 3, 70, 8]
print(array2)
showArray(array2)
let intCmp = {
    (a: Int, b: Int) -> Int in
    if a > b {
        return 1
    } else if a < b {
        return -1
    } else {
        return 0
    }
}
bubbleSort2(array: &array2,cmp: intCmp)
showArray(array2)
var array3 = [20, 2, 3, 70, 8]
showArray(array3)
bubbleSort2(array: &array3,cmp:{
    (a: Int, b: Int) -> Int in
    if a > b {
        return 1
    } else if a < b {
        return -1
    } else {
        return 0
    }
})
showArray(array3)
bubbleSort2(array: &array3,cmp:{
    if $0 > $1 {
        return 1
    } else if $0 < $1 {
        return -1
    } else {
        return 0
    }
})

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
let names2 = ["Chris", "Ewa", "Alex", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
print(reversedNames)
reversedNames = names2.sorted(by: backward)
print(reversedNames)
func backward2(_ s1: String, _ s2: String) -> Bool {
    return s1 < s2
}
reversedNames = names.sorted(by: backward2)
print(reversedNames)

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2} )
print(reversedNames)

/*
 从语境中推断它的形式参数类型和返回类型。
 所有的类型能够推断，返回箭头（->)和围绕在形式参数名周围的括号也能够被省略
 */
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
/*
 从单表达式闭包隐式返回
 删除return 关键字来隐式返回它们单个表达式的结果
 */
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

/*
 简写实际参数名
 通过$0, $1, $2等名字来引用闭包的实际参数值
 如果在闭包表达式中使用这些简写实际参数名，那么可以在闭包的实际参数列表中忽略对其的定义，并且简写实际参数名的数字和类型将会从期望的函数类型中推断出来。
 in 关键字也能被省略，因为闭包表达式完全由它的函数体组成：
 reversedNames = names.sorted(by: { $0 > $1} )
 */
reversedNames = names.sorted(by: { $0 > $1})

/*
 运算符函数
 实际上还有一种更简短的方式来撰写上述闭包表达式。Swift的 String 类型定义了关于大于号（ > )的特定字符串实现，让其作为一个有两个String类型形式参数的函数并返回一个Bool类型的值。
 */
reversedNames = names.sorted(by: >)// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]

/*
 尾随闭包
 如果需要将一个很长的闭包表达式作为函数最后一个实际参数传递给函数，使用尾随闭包酱增强函数的可读性。尾随闭包是一个被书写在函数形式参数的括号外面（后面）的闭包表达式：
 */
func someFunctionThatTaskAClosure(closure:() -> Void){
    //function body goes here
}

//不使用尾随闭包
someFunctionThatTaskAClosure (closure: {
    //closure's body goes here
})

//使用尾随闭包
someFunctionThatTaskAClosure() {
    //trailing closure's body goes here
}
//来自于上文的闭包表达式的字符串排列闭包也可以作为一个尾随闭包被书写在sorted(by:)方法的括号外面：
reversedNames = names.sorted(){ $0 > $1 }
//如果闭包表达式作为函数的唯一实际参数传入。而你又使用了尾随闭包的语法，那就不需要在函数名后边写圆括号了：
reversedNames = names.sorted { $0 > $1 }
//当闭包很长以至于不能被写成一行时，尾随闭包就显得非常有用了。
let digtNames = [0: "Zero",1: "One",2: "Two", 3: "Three",4: "Four", 5: "Five",6: "Six",7: "Seven",8: "Eight",9: "Nine"]
let numbers = [16, 58, 510]
let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digtNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
print(strings)
// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]
//digitNames的下标紧跟着一个感叹号（！），因为字段下标返回一个可选值，表明即使该key 不存在也不会查找失败，上述这个例子中，保证了number%10可以总是作为字典digitNames的下标key，因此一个感叹号可以被用作枪支展开（force-unwrap） 存储在可选返回值下标项的 String 值


//捕获值
//一个闭包能够从上下文捕获已被定义的常量或者变量。即使定义了这些常量和变量的原作用域已经不存在，闭包仍然能够在其函数体内引用和修改这些值

//在Swift中，一个能够捕获值的闭包最简单的模型时内嵌函数，即被书写在另一个函数的内部。一个内嵌函数能够捕获外部函数的实际参数并且能够捕获任何外部函数内部定义了的常量和变量
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
//incrementer()函数没有任何形式参数，runningTotal 和amount不是来自于函数体的内部，而是通过捕获主函数的runningTotal和amount把它们内嵌在自身函数内部供使用。当调用makeIncrementer结束时通过捕获来确保不会消失，并确保了在下次调用incrementer时，runningTotal将继续增加
//注意：作为一种优化，如果一个值没有改变或者在闭包的外面，Swift可能活使用这个值的拷贝而不是捕获，Swift也处理了变量的内部管理操作。当变量不再需要时会被释放
let incrementByTen = makeIncrementer(forIncrement: 10)
var value = incrementByTen()
print("value equals \(value) now")
value = incrementByTen()
print("value equals \(value) now")
value = incrementByTen()
print("value equals \(value) now")

//如果建立第二个incrementer,它将会有一个新的，独立的runningTotal变量引用
let incrementBySeven = makeIncrementer(forIncrement: 7)
value = incrementBySeven()
print("value equals \(value) now")

//再次调用原来的增量器，继续增加它自己的变量runningTotal的值，并且不会影响incrementBySeven捕获runningTotal值
value = incrementByTen()
print("value equals \(value) now")

//(7)闭包值捕获
func getIncFunc(inc: Int) -> (Int) -> Int {
    var mt = 10
    func incFunc(v: Int) -> Int {
        mt += 1
        return inc + v + mt
    }
    return incFunc
}
let incFunc1 = getIncFunc(inc: 3)
let incFunc2 = getIncFunc(inc: 3)
print(incFunc1(10))
print(incFunc1(10))
print(incFunc2(10))

//闭包时引用类型
//incrementBySeven 和 incrementByTen 是常量，但是这些常量指向的闭包仍可以增强已捕获的变量runningTotal的值，这是因为函数和闭包都是引用类型，无论你什么时候赋值一个函数或者闭包给常量或者变量，实际上都是将常量和变量设置为对函数和闭包的引用。上年的例子中，闭包选择incrementByTen指向一个常量，而不是闭包它自身的内容
//意味着你赋值一个闭包到两个不同的常量或变量中，这两个常量或者变量豆浆指向相同的闭包
let alseIncrementByTen = incrementByTen
value = alseIncrementByTen()
print("value equals \(value) now")

//逃逸闭包
//当闭包作为一个实际参数传递给一个函数的时候，我们就说这个闭包逃逸了，因为它可以在函数返回之后被调用，当你声明一个接受闭包作为形式参数的函数时，你可以在形式参数前写 @escaping 来明确闭包是允许逃逸的
//闭包可以逃逸的一种方法是被储存在定义于函数外的变量里，比如说，很多函数接收闭包实际参数来作为启动异步任务的回调。函数在启动任务后返回，但是闭包药知道任务完成——闭包需要逃逸，以便稍后调用。举例来说
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
//函数 someFunctionEscapingClosure(_:) 接收一个闭包作为实际参数并且添加它到声明的函数外部的数组里，如果不标记函数的形式参数为 @escaping，就会遇到编译时错误
//让闭包 @escaping 意味着必须在闭包中显式地引用self，比如说，下面的代码中国年，传给someFunctionWithEscapingClosure(_:)的闭包是一个逃逸闭包，也就是说它需要显式的引用self。相反，传给someFunctionWithNonescapingClosure(_:)的闭包时非逃逸闭包，也就是说它可以隐式的应用self
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
class SomeClass {
    var x = 10
    func doSomething(){
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)//200
completionHandlers.first?()//（等价于？）completionHandlers[0]()

print(instance.x)//100

/*
 自动闭包
 自动闭包是一种自动创建的用来把作为实际参数传递给函数的表达式打包的闭包。它不接受任何实际参数，并且当它被调用时，它会返回内部打包的表达式的值。这个语法的好处在于通过写普通表达式代替显式闭包而使省略包围函数形式参数的括号
 自动闭包允许延迟处理，因此闭包内部的代码直到调用的时候才会运行，对于有副作用或者占用资源的代码来说很有用，因为它可以允许控制代码何时才进行求值，下面的代码展示了闭包如何延迟求值
 */
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)//5

let customersProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)//5

print("Now serving \(customersProvider())!")
//Now serving Chris!
print(customersInLine.count)//4

//尽管customerInLine数组的第一个元素以闭包的一部分被移除了，但闭包没有被实际调用的时候任务并没有执行。如果闭包永远不被调用，那么闭包里边的表达式就永远不会求值。 注意 customerProvider 的类型不是String，而是 ()-> String —— 一个不接受实际参数并且返回一个字符串的函数
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String){
    print("Now serving \(customerProvider())!")
}
serve(customer: {customersInLine.remove(at: 0)})
// Now serving Alex!
//上边的函数 serve(customer:)接收一个明确的返回下一个客户名称的闭包。下面另一个版本的serve(customer:)执行相同的任务，但是不使用明确的闭包而是通过@autoclosure 标志标记它的形式参数使用了自动闭包。现在可以调用函数就像他接受了一个String实际参数而不是闭包。实际参数自动地转换为闭包，因为customerProvider形式参数的类型被标记为@autoclosure标记
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String ) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
//滥用自动闭包会导致代码难以读懂，上下文和函数名应该写清楚求值是延迟的

//自动闭包允许逃逸，就同时使用 @autoclosure 和 @escaping
// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customersProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print(customersInLine.count)//2

for customersProvider in customerProviders {
    print("Now serving \(customersProvider())")//逃逸后，此时闭包才被调用
}
print(customersInLine.count)//0
