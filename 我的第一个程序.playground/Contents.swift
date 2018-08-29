//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground!"

let 订购按钮 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))

订购按钮.text = "加入购物车！"
订购按钮.textColor = UIColor.white

订购按钮.backgroundColor = UIColor.brown
订购按钮.textAlignment = .center

订购按钮.layer.cornerRadius = 10
订购按钮.clipsToBounds = true

订购按钮