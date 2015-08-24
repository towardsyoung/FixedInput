# FixedInput
A ios phonegap plugin which clould fix the fixed input bug
该方法只适合phonegap应用。利用phonegap插件开发，使用原生的输入框替代position:fixed的input。先看下效果：
![这里写图片描述](http://img.blog.csdn.net/20150824175705107)
***使用方法：***
1.将插件安装到你的phonegap项目
```cordova plugin add https://github.com/towardsyoung/FixedInput.git```
2.在页面上调用js接口
显示并聚焦输入框
 ```navigator.fixedInput.showAndFocus(function(content){
            alert(content);
 }, 'hello world', '发送');```
 第一个参数是点击发送按钮的回调函数，content为输入的内容
 第二个参数为输入框的默认文字
 第三个参数为按钮的默认文字
 其他接口：
navigator.fixedInput.show(sendCallback, defaultVal, btnText) 显示输入框
navigator.fixedInput.hide();隐藏输入框
