cordova.define("ccy.plugins.fixedInput", function(require, exports, module) {
               
    var exec = require('cordova/exec');
               
    var fixedInput = {
        show:function(sendCallback, defaultVal, btnText) {
            if (!defaultVal) {
               defaultVal = "";
            }
            if (!btnText) {
               btnText = "回复";
            }
            exec(sendCallback, null, "FixedInput", "show", [defaultVal, btnText]);
        },
        showAndFocus:function(sendCallback, defaultVal, btnText) {
            if (!defaultVal) {
               defaultVal = "";
            }
            if (!btnText) {
               btnText = "回复";
            }
            exec(sendCallback, null, "FixedInput", "showAndFocus", [defaultVal, btnText]);
        },
        hide:function() {
            exec(null, null, "FixedInput", "hide", []);
        }
    };
            
    module.exports = fixedInput;
});

