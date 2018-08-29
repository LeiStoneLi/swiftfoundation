//
//  main.swift
//  Lesson3Project
//
//  Created by SrearAlex on 2016/12/13.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//
/*
集合数据类型
 数组：
 （1）Swift数组的概念和定义
 （2）对数据类型数组
 （3）swift数组的操作：增加／删除／修改
 （4）Range和Slide
 （5）swift数组的批量操作
 （6）swift数组的遍历
 字典：
 （1）字典的概念和定义
 （2）字典的操作
 （3）字典的遍历
 */
import Foundation
/*
 数组的定义和概念
 相同类型的数据在内存中的连续排布，优势在于数据的检索非常的快速
 */
var array = [2, 3, 4, 5]
var array1: Array = [2, 3, 4, 5]
var array2: Array<Int> = [2, 3, 4, 5]
var array3: [Int] = [2, 3, 4, 5]//官方推荐方式
var array4:[Double] = [2.2, 3.5]
print(array)
//创建一个空数组
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items")
array4 = []
print(array4)
/*
 使用默认值创建数组
 创建确定数组大小且元素都设定为相同默认值的数组。可以传给初始化器对应类型的默认值（叫做repeating）和新数组元素的个数（叫做count）
 */
var threeDoubles = Array(repeating: 1, count: 3)
print(threeDoubles)
/*
 通过连接两个数组来创建数组 +
 */
var anotherThreeDoubles = Array(repeating: 2, count: 3)
var sixDoubles = threeDoubles + anotherThreeDoubles
print(sixDoubles)
//count属性得出数组中元素的数量
var shoppingList = ["Eggs", "Milk"]
print("The shopping list cntains \(shoppingList.count) items")
//isEmpty属性来作为检查count属性是否等于 0 的快捷方式
if shoppingList.isEmpty {
    print("The shopping list is empty")
} else {
    print("The shopping list is not empty")
}
// append(-:)方法给数组末尾添加新元素
shoppingList.append("Flour")//面粉
// 可以通过赋值运算符(+=)来在数组的末尾添加一个或者多个同类型元素：
shoppingList += ["Baking Powder"]//发酵粉
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
//通过下标标注语法来从数组中取回一个值，在紧跟数组名后的方括号内传入想要取回的值的索引,swift中数组的索引是从0开始的
var firstItem = shoppingList[0]
print(firstItem)
//使用下标脚本语法来改变给定索引中已经存在的值
shoppingList[0] = "Six eggs"
//可以使用下标脚本语法一次改变一个范围的值，即使替换与范围长度不同的值的合集也可以
shoppingList[4 ... 6] = ["Bananas", "Apples"]
print(shoppingList)
//把元素插入到指定的索引位置, 注意插入的位置的大小最大等于数组的元素的个数
shoppingList.insert("Maple Syrup", at: 0)
print(shoppingList)
//remove(at:Int)方法来移除一个元素,同样注意下标不要越界，这个方法一处特定索引的元素并且返回它（不需要可以无视）
let mapleSyrup = shoppingList.remove(at: 0)
//数组元素被移除后，任何留下的空白都会被封闭，所以索引0的值再一次等于“Six eggs”
firstItem = shoppingList[0]
print(firstItem)
//如果想要移除最后一个元素，使用removeLast(),而不是remove(at: 数组.count - 1)避免查询数组的count属性,与remove（）方法相同，返回删除了的元素
let apples = shoppingList.removeLast()
print(apples)
/*
 遍历一个数组
 */
for item in shoppingList {
    print(item)
}
//enumerated()方法返回数组中每一个元素的元组，包含了这个元素的索引和值
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}
//(2) 数组中是否可以放置不同类型的数据
var array6: Array<Any> = ["a", 1, 2.3]
print(array6)
//删除所有元素，并保持容量
array6.removeAll(keepingCapacity: true)
print(array6.capacity)
//数组与Slice,swift 3 中剔除
//(6)Range
var range = 0 ... 5
var range1: Range<Int> = Range(0 ... 5)
var range2 = 0 ..< 5
print(range)
print(range1)
print(range2)
//数组的批量操作
var array10 = [1, 2, 3, 4, 5]
//array10[0 ... 1] = [9 , 9, 9, 9]
array10.replaceSubrange(0 ... 1, with: [9 , 9, 9, 9])
print(array10)
/*
 合集
 合集将同一类型且不重复的值无序的储存在一个集合当中，当元素的顺序不那么重要的时候，就可以使用合集来代替数组，或者需要确保元素不会重复的时候
 
 Set类型的哈希值
 为了能够让类型储存在合集当中，它必须是可哈希的——就是说类型必须提供计算它自身哈希值的方法，哈希值是Int值且所有的对比起来相等的对象都相同，比如a == b，它遵循的是a.hashValue == b.hashValue
 所有Swift基本类型（比如 Int String，Double， Bool，Float，Charater）默认都是可哈希的，并且可以用于合集或者字典的键。没有关联值的枚举成员值（如同枚举当中描述的那样）同样默认可哈希
 */
//合集的类型语法 Swift 的合集类型写作 Set<Element>, 这里的Element是合集要储存的类型，不同于数组，合集没有等价的简写
//创建并初始化一个空合集
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items")
//如果内容已经提供了类型信息，比如函数实际的参数活着已经分类的变量常量，你就可以用空的数组字面量来创建一个空合集：
letters.insert("a")
print("letters is of type Set<Character> with \(letters.count) items")
letters = []
print("letters is of type Set<Character> with \(letters.count) items")
//写一个或者多个合集值的快捷方式，使用数组字面量来初始化一个合集
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
//可以简写为var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]，但是Set 不能省略，因为合集类型不能从数组字面量上推断出来
//访问和修改合集
//count属性
print("I have \(favoriteGenres.count) favorite music genres")
//isEmpty ,检查count属性是否等于0的快捷方式
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
//insert(_:)添加一个新的元素
favoriteGenres.insert("Jazz")
for genre in favoriteGenres {
    print(genre)
}
//remove(_:)方法从合集移除一个元素，并且返回移除的值，如果合集没有这个成员，就返回nil。removeAll()可以移除合集中的所有元素
if let removedGenere = favoriteGenres.remove("Rock") {
    print("\(removedGenere)? I'm over it, I have \(favoriteGenres.count) favorite music genres")
//    favoriteGenres.insert("Rock")
} else {
    print("I never much cared for that")
}
//contains(_:)方法检查合集中是否包含了特定的元素
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
//遍历合集 for-in循环里遍历合集的值
for genre in favoriteGenres {
    print(genre)
}
//Swift的Set类型是无序的，要以特定的顺序遍历合集的值，使用sorted（）方法，它把合集的元素使用< 运算符排序了的数组返回。
for genre in favoriteGenres.sorted() {
    print(genre)
}
/*
 执行合集操作
 a和b的交集 a.intersection(b)
 a和b中专有的元素 只存在a和b的一个集合中，包含两个合集各自有的非公有值的新合集，a.symmetricDifference(b)
 a和b的合集 a.union(b)
 a-b a中元素剔除b中包含的元素剩余的元素的集合a.subtracting(b)
 a集合与b集合的补集，a是b的子集，b中剔除a中所有元素剩余部分,无专用方法，使用b.subtracting(a)
*/
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2 ,3, 5, 7]
let evenDigits2: Set = [2, 4, 6, 8]
let evenDigits3: Set = [2, 4, 6, 8]
print(oddDigits.union(evenDigits).sorted())
print(oddDigits.intersection(evenDigits).sorted())
print(oddDigits.subtracting(singleDigitPrimeNumbers).sorted())
print(oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted())
print(evenDigits.subtracting(evenDigits2).sorted())
/*
 （1）== 判断两个集合是否相等
 （2）a.isSubset(of:b),判断a是否是b的子集，a是否被b包含
 （3）a.isSuperset(of:b),判断a是否是b的超集，a是否包含b的所有值
 （4）a.isStrictSubset(of:b),判断a是否是b的真子集，a是否被b包含但不相等
 （5）a.isStrictSuperser(of:b),判断a是否是b的真超集，a是否包含b的所有值，但不相等
 */
print(evenDigits2.isSubset(of: evenDigits))//true
print(evenDigits.isSuperset(of: evenDigits2))//true
print(evenDigits2.isStrictSubset(of: evenDigits3))//false
print(evenDigits2.isStrictSuperset(of: evenDigits3))//false

/*
 (1)字典的概念和定义(key: value)
addr = hash(key),value = hashTable[addr]
 字典储存无序的互相关联的同一类型的键和同一类型的值的集合，每一个值都与唯一的键相关联，它就好像这个值的身份标记一样，不同于数组中的元素，字典中的元素没有特定的顺序。
 字典的典型写法：Dictionary<Key, Value>,其中Key是用来作为字典键的值类型，Value就是字典为这些键储存的值的类型
 */
//创建一个空字典
var nameOfIntegers = [Int: String]()
//如果内容已经提供了信息，可以用字典字面量创建空字典，写作[:]
print("nameOfIntegers = \(nameOfIntegers)")
nameOfIntegers[16] = "sixteen"
print("nameOfIntegers = \(nameOfIntegers)")
nameOfIntegers = [:]
print("nameOfIntegers = \(nameOfIntegers)")
var nameOfIntegers2: Dictionary<Int, String>
//不可以使用，因为还未初始化print("nameOfIntegers2 = \(nameOfIntegers2)")
nameOfIntegers2 = [:]
print("nameOfIntegers2 = \(nameOfIntegers2)")
var airports: [String: String] = ["YYZ": "Toronto Pearson","DUB": "Dublin"]
//使用字典字面量创建字典 可以简写为
var airports2 = ["YYZ": "Toronto Pearson","DUB": "Dublin"]
airports2 = [:]
//访问和修改字典
//可以使用count只读属性来找出字典有多少元素
print("The airports dictionary contains \(airports.count) items")
//isEmpty属性检查count属性是否等于0
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}
//使用正确类型的新键作为下标脚本的索引，然后赋值一个正确类型的值：
airports["LHR"] = "London"
print("The airports dictionary contains \(airports.count) items")
//使用下标脚本语法来改变特定键关联的值
airports["LHR"] = "London Heathrow"
//updateValue(_:forKey:)方法来设置或更新特定键的值，在键没有值的时候设置一个值，或者在键有值的时候更新，它可以返回旧的值，允许检查更新是否成功
//updateValue(_:forKey:)方法返回一个字典值类型的可选项值，比如对于储存String值的字典来说，方法返回String？类型的值，或者说是 “可选的String”如果更新了话这个可选项包含了键的旧值，否则就是nil
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
}
if let oldValue = airports2.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
} else {
    print("The airports2 dictionary is \(airports2)")
}
//使用下标脚本语法来从字典的特定键中取值，由于可能请求的键没有值，字典的下标脚本返回可选的字典值类型，如果字典中包含了请求的键的值，则下标脚本就返回包含这个键的值的可选项，否则，返回nil
if let airportName = airports["DUB"] {
    print("The name of airport \"DUB\" is \(airportName) ")
} else {
    print("That airport is not in the airports dictionary.")
}
//使用下标标注语法给一个键赋值nil 来从字典当中移除一个键值对
airports["APL"] = "Apple International"
print("The airports dictionary is \(airports)")
airports["APL"] = nil
print("The airports dictionary is \(airports)")
//removeValue(forKey:)来从字典里移除键值对，如果键值对存在的话，返回移除的值，如果不存在的话，返回nil
if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport\'s name is \(removedValue)")
} else {
    print("The airports dictionary does not contaions a value for DUB.")
}
if let removedValue = airports.removeValue(forKey: "APL") {
    print("The removed airport\'s name is \(removedValue)")
} else {
    print("The airports dictionary does not contaions a value for APL.")
}
//removeAll() removeAll(keepingCapacity)
airports2.removeAll(keepingCapacity: true)
//遍历字典，用 for-in循环来遍历字典的键值对。字典中的每一个元素返回为（key，value）元组，，可以解开元组的成员到临时常量或者变量来作为遍历的一部分
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
//访问字典的keys和values属性来取回可遍历的字典的键或者值的集合
for airportCode in airports.keys {
    print("Airport Code: \(airportCode)")
}
for airportCode in airports.values {
    print("Airport Name: \(airportCode)")
}
//Dictionary是无序的，要以特定顺序遍历字典的键或者值，使用键或者值的sorted（）方法
