# FixedInput
A ios phonegap plugin which clould fix the fixed input bug
该方法只适合phonegap应用。利用phonegap插件开发，使用原生的输入框替代position:fixed的input。先看下效果：<br/>
![这里写图片描述](http://img.blog.csdn.net/20150824175705107)<br/>
***使用方法：***<br/>
1.将插件安装到你的phonegap项目<br/>
`cordova plugin add https://github.com/towardsyoung/FixedInput.git`<br/>
2.在页面上调用js接口<br/>
显示并聚焦输入框
 `navigator.fixedInput.showAndFocus(function(content){`<br/>
         `alert(content);`<br/>
 `}, 'hello world', '发送');`<br/>
 第一个参数是点击发送按钮的回调函数，content为输入的内容<br/>
 第二个参数为输入框的默认文字<br/>
 第三个参数为按钮的默认文字<br/>
 其他接口：<br/>
navigator.fixedInput.show(sendCallback, defaultVal, btnText) 显示输入框<br/>
navigator.fixedInput.hide();隐藏输入框
