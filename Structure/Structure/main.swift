//
//  main.swift
//  Structure
//
//  Created by SrearAlex on 2016/12/20.
//  Copyright © 2016年 SrearAlex. All rights reserved.
//

import Foundation
/*
            第8章：结构体和类的初步
 （1）结构体定义
 （2）结构体实例和属性访问
 （3）结构体的构造器
 （4）给结构体加上方法
 （5）结构体是值引用
 （6）类定义
 （7）类和结构体的比较
 （8）类和引用类型
 （9）恒等运算符
 */
//（1）定义
//矩形
struct Rect {
    var width: Double = 10.0
    var height: Double = 10.0
    //成员方法可以访问使用成员属性
    func getWidth() -> Double {
        return width
    }
    func show(){
        print("width=\(width), height=\(height)")
    }
}
//(2)结构体实例和访问
var rect: Rect = Rect()
print("\(rect.height), \(rect.width)")
rect.height = 10
rect.width = 10
print("\(rect.height), \(rect.width)")
var rect1: Rect = Rect()
print("\(rect.height), \(rect.width)")
rect1.width = 100
rect1.height = 100
print("\(rect.height), \(rect.width)")
//（3）结构体的构造器
//结构体逐一成员构造器
var rect2: Rect = Rect(width: 9, height: 9)
//当给每一个成员都提供初始值，则还提供不带任何参数的构造器
print("\(rect2.width), \(rect2.height)")
//成员方法的调用语法 对象.方法()
rect2.getWidth()
rect2.show()

var rect3 = rect2
//rect3是Rect类型，等于rect2
//假设（1）rect3和rect2指向同一块内存 （2）rect3和rect2是两个不同的实例，但是内容一致 正确
rect2.width = 99
rect2.show()
rect3.show()
//结构体是值类型，当我们用一个结构体对象给另外一个结构体对象赋值的时候，仅仅是将它的值拷贝过来，而不是让两个对象指向同一块内存

//类 面向对象概念中 类是指具有相同属性和行为的对象的抽象，封装成一个模版
/*
 class 类名称 {
 
 }
 成员变量，成员方法
 */
class Rectangle {
    var width: Double = 10.0
    var height: Double = 10.0
    //成员方法可以访问使用成员属性
    func getWidth() -> Double {
        return width
    }
    func show(){
        print("width=\(width), height=\(height)")
    }
}
var rectangle = Rectangle()
rectangle.width = 100
rectangle.height = 100
var rectangle2 = rectangle
//rectangle3是Rectangle类型，等于rectangle
//假设（1）rectangle赋值给了rectangle，将rectangle2和rectangle指向同一块内存  正确（2）rectangle和rectangle是两个不同的实例，但是内容一致 错误
rectangle.width = 99
rectangle.show()
rectangle2.show()
//类类型是引用类型，当我们用一个类对象给另一个类对象赋值的时候，让两个对象指向同一个引用，指向同一块儿内存 ，而不是值拷贝

// ===（恒等于,等价于）!==(恒不等于，不等价于) 判断两个对象是否指向同一个类的实例
//== != 关系运算符 进行比较，比较运算符左边是否等于右边
if rectangle === rectangle2 {
    print("equal")
}

/*
     类与结构体的对比
 在Swift中类和结构题有很多共同之处，它们都能：
 
 定义属性用来存储值；
 定义方法用于提供功能；
 定义下标脚本用来允许使用下标语法访问值；
 定义初始化器用于初始化状态；
 可以被扩展来默认所没有的功能；
 遵循协议来针对特定类型提供标准功能
 
 类有而结构体没有的额外功能：
 继承允许一个类继承另一个类的特征；
 类型转换允许在运行检查和解释一个类实例的类型；
 反初始化器允许一个类实例释放任何其所被分配的资源；
 引用计数允许不知一个类实例的引用
 
 
 注意：结构体在代码中通过赋值来传递，并且并不会使用计数。
 */
/*
        定义语法
 类与结构体有着相似的定义语法，可以通过使用关键词 class 来定义类  使用关键词 struct 来定义结构体。并在一对大括号内定义它们的具体内容
 */
class SomeClass {
    // class definition goes here
}
struct SomeStruct {
    //struct definition goes here
}
/*
 注意：
 无论你在何时定义了一个新的类或者结构体，实际上你定义了一个全新的Swift类型。要使用 首字母大写命名法（大驼峰命名法）以符合Swift的字母大写风格。相反，对于属性和方法使用 lowerCamelCase（小驼峰命名法），以此来区别类型名称
 */
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

/*
 上面这个例子中定义了一个名叫Resolution的新结构体，用来描述一个基于像素的显示器分辨率。这个结构体拥有两个存储属性名叫 width 和 height ，存储属性是绑定并储存在类或者结构体中的常量或者变鼌。这两个属性因以0来初始化，所以它们的类型推擦为Int。
 
 上面这个例子也定义了一个名叫VideoMode的新类，用来描述一个视频显示的特定视频模式。这个类有四个变量存储属性。第一个， resolution用Resolution结构体实例来初始化，它使属性的类型推断为Resolution。对于其他三个属性来说，新的VideoMode实例将会以interlaced为false（意思是“非隔行扫描视频”），回放帧频为0.0，和一个名叫name的可选项 String 值来初始化。name属性会自动被赋予一个空值nil ，或“无那么值”因为它是一个可选项
 */

/*
            类与结构体实例
 Resolution结构体的定义和VideoMode类的定义仅仅描述了什么是Resolution或VideoMode。它们并没有描述一个特定的分辨率或视频模式，对此，你需要创建一个结构体或类的实例
 创建结构体和类的实例的语法是非常相似的：
 */
let someResolution = Resolution()
let someVideoMode = VideoMode()
/*
 结构体和类两者都能使用初始化器语法来生成新的实例。初始化器语法最简单的事在累活结构体名字后面接一个空的圆括号，例如 Resolution()或者VideoMode().这样就创建了一个新的类或者结构体的实例，任何属性都被初始化为它们的默认值。
 */

/*
            访问属性
 可以用点语法来访问一个实例的属性。在点语法中，只需要在实例名后面书写属性名，用（.）来分开，无需空格
 */
print("The width of someResolution is \(someResolution.width)")
//The width of someResolution is 0
//在这个例子中，someResolution.width就是someResolution中的width属性，返回一个它的默认初始值 0.

//可以继续下去访问字属性，如VideoMode中resolution属性中的width属性：
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
//The width of someVideoMode is 0

//使用点语法来指定一个新值到一个变量属性中：
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
//The width of someVideoMode is now 1280
/*
 注意：
 不同于Objecive-C，Swift允许直接设置一个结构体属性中的子属性，在上述最后一个例子中，someVideoMode的resolution属性中的width这个属性可以直接设置，不用重新设置整个resolution属性到一个新值
 */

/*
 结构体类型的成员初始化器
 所有的结构体都有一个自动生成的成员初始化器，可以使用它来初始化新结构体实例的成员属性。新实例属性的初始化值可以通过属性名称传递到成员初始化器中：
 */
let vga = Resolution(width: 640, height: 480)
//与结构体不同，类实例不会接受默认的成员初始化器

/*
 结构体和枚举是值类型
 值类型是一种当它被指定到常量或者变量，或者被传递给函数时会被拷贝的类型。
 Swift中国年所有的基本类型——整数，浮点数，布尔量，字符串，数组和字典——都是值类型，并且都以结构体的形式在后台实现
 Swift中所有的结构体和枚举都是值类型，这意味着你所创建的任何结构体和枚举实例——和实例作为属性所包含的任意值类型——在代码传递总是被拷贝的，
 */

var cinema = Resolution(width: 1920, height: 1080)
var hd = cinema

/*
 这个例子声明了一个叫cinema的变量，并且赋予它一个全高清视频（1920像素宽乘以100像素高）宽和高初始化的Resolution实例
 
 之后声明了一个叫做hd的变量并且以当前hd的值进行初始化。因为Resolution是一个结构体。现有实例的拷贝会被制作出来，然后将这份新的拷贝赋值给了hd。尽管hd和cinema有相同的像素宽和像素高，但是在后台，它们是两个完全不同的实例
 
 接下来，为了适应数字影院的放映需求（2048像素宽和1080像素高），我们把cinema的属性width修改为稍宽一点的2K标准
 */
cinema.width = 2048
//检查cinema的width属性发现已被改成2048:
print("cinema is now \(cinema.width) pixels wide")
//hd实例中的width属性依旧是1920:
print("hd is still \(hd.width) pixels wide")

/*
 当 hd被赋予 cinema的当前值，存储在 cinema中的值就被拷贝给了新的 hd实例。这最终的结果是两个完全不同的实例，它们只是碰巧包含了相同的数字值。由于它们是完全不同的实例， cinema的宽度被设置 2048并不影响 hd中 width存储的值。
 */

/*
                枚举中
 */
enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}//The remembered direction is still .West
//当 rememberedDirection被赋予了 currentDirection中的值，实际上是值的拷贝。之后再改变 currentDirection的值并不影响 rememberedDirection所存储的原版值。
/*
            类是引用类型
不同于值类型，在引用类型被赋值到一个常量，变量或者本身被传递到一个函数的时候它是不会被拷贝的。相对于拷贝，这里使用的是同一个对现存实例的引用。
 
这里有个栗子，使用上面定义的 VideoMode类：
 */

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
/*
 声明了一个新的名叫 tenEighty的常量并且设置它引用一个 VideoMode类的新实例，这个视频模式复制了之前的 1920 乘 1080的HD分辨率。同时设置为隔行扫描，并且给予了一个名字“ 1080i”。最后，设置了 25.0帧每秒的帧率。
 然后， tenEighty是赋给了一个名叫 alsoEighty的新常量，并且将其帧率修改：
 */
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
/*
 因为类是引用类型， tenEighty 和 alsoTenEighty其实都是引用了相同的 VideoMode实例。实际上，它们只是相同实例的两个不同命名罢了。

 下面， tenEighty的 frameRate属性展示了它正确地显示了来自于 VideoMode实例的新帧率：
 */
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")//The frameRate property of tenEighty is now 30.0
/*注意 tenEighty和 alsoTenEighty都被声明为常量。然而，你仍然能改变 tenEighty.frameRate和 alsoTenEighty.frameRate因为 tenEighty和 alsoTenEighty常量本身的值不会改变。 tenEighty和 alsoTenEighty本身是并没有存储 VideoMode实例—相反，它们两者都在后台指向了 VideoMode实例。这是 VideoMode的 frameRate参数在改变而不是引用 VideoMode的常量的值在改变。
*/

/*
特征运算符

因为类是引用类型，在后台有可能有很多常量和变量都是引用到了同一个类的实例。(相同这词对结构体和枚举来说并不是真的相同，因为它们在赋予给常量，变量或者被传递给一个函数时总是被拷贝过去的。)

有时候找出两个常量或者变量是否引用自同一个类实例非常有用，为了允许这样，Swift提供了两个特点运算符：

相同于 ( ===)
不相同于( !==)
利用这两个恒等运算符来检查两个常量或者变量是否引用相同的实例：

*/
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
//tenEighty and alsoTenEighty refer to the same VideoMode instance.
/*
注意”相同于”(用三个等于号表示，或者说 ===)这与”等于”的意义不同(用两个等于号表示，或者说 ==)。
    
“相同于”意味着两个类类型常量或者变量引用自相同的实例；
“等于”意味着两个实例的在值上被视作“相等”或者“等价”，某种意义上的“相等”，就如同类设计者定义的那样。
当你定义了你自己的自定义类和结构体，你有义务来判定两个实例”相等”的标准。这个定义在你自己的”等于”和”不等于”实现的过程在相等运算符(此处应有链接)中有详细的介绍。
 */
/*
                        指针

如果你有过 C，C++ 或者 Objective-C 的经验，你可能知道这些语言使用可指针来引用内存中的地址。一个 Swift 的常量或者变量指向某个实例的引用类型和 C 中的指针类似，但是这并不是直接指向内存地址的指针，也不需要你书写星号( *)来明确你建立了一个引用。相反，这些引用被定义得就像 Swift 中其他常量或者变量一样。

类和结构体之间的选择

类和结构体都可以用来定义自定义的数据类型，作为你的程序代码构建块。

总之，结构体实例总是通过值来传递，而类实例总是通过引用来传递。这意味着他们分别适用于不同类型的任务。当你考虑你的工程项目中数据结构和功能的时候，你需要决定把每个数据结构定义成类还是结构体。

按照通用准则，当符合以下一条或多条情形时应考虑创建一个结构体：

结构体的主要目的是为了封装一些相关的简单数据值；
当你在赋予或者传递结构实例时，有理由需要封装的数据值被拷贝而不是引用；
任何存储在结构体中的属性是值类型，也将被拷贝而不是被引用；
结构体不需要从一个已存在类型继承属性或者行为。
合适的结构体候选者包括：

几何形状的大小，可能封装了一个 width属性和 height属性，两者都为 double类型；
一定范围的路径，可能封装了一个 start属性和 length属性，两者为 Int类型；
三维坐标系的一个点，可能封装了 x , y 和 z属性，他们都是 double类型。
在其他的情况下，定义一个类，并创建这个类的实例通过引用来管理和传递。事实上，大部分的自定义的数据结构应该是类，而不是结构体。
 字符串，数组和字典的赋值与拷贝行为
 
 Swift 的 String , Array 和 Dictionary类型是作为结构体来实现的，这意味着字符串，数组和字典在它们被赋值到一个新的常量或者变量，亦或者它们本身被传递到一个函数或方法中的时候，其实是传递了拷贝。
 
 这种行为不同于基础库中的 NSString, NSArray和 NSDictionary，它们是作为类来实现的，而不是结构体。 NSString , NSArray 和 NSDictionary实例总是作为一个已存在实例的引用而不是拷贝来赋值和传递。
 
 注意
 
 在上述有关字符串，数组和字典“拷贝”的描述中。你在代码中所见到的行为好像总是拷贝。然而在后台 Swift 只有在需要这么做时才会实际去拷贝。Swift 能够管理所有的值的拷贝来确保最佳的性能，所有你也没必要为了保证最佳性能来避免赋值。
 */
