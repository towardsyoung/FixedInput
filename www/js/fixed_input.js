    var exec = require('cordova/exec');

    var fixedInput = {
        show:function(sendCallback, defaultVal) {
            exec(sendCallback, null, "FixedInput", "show", [defaultVal]);
        },
        showAndFocus:function(sendCallback, defaultVal) {
            exec(sendCallback, null, "FixedInput", "showAndFocus", [defaultVal]);
        },
        hide:function() {
            exec(null, null, "FixedInput", "hide", []);
        }
    };

    module.exports = fixedInput;
