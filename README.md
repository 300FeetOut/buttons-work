# buttons-work
Buttons work. Really, they do.

A simple package for hooking up buttons to arbitrary code.

Usage
=====
```javascript
        // Include the package.
        buttonsWork = require('buttons-work');
  
        // Create a config object.
        buttonConfig = {
            buttonName: {
                pins: {light: LED_Pin_Number_Here, button: Button_Pin_Number_Here},
                do: Your_Function_Here,
                delay: 1000 // (Optional. Time in MS delay after button is pressed before executing function.)
            }
        }

        // Init using your config object.
        buttonsWork.init(buttonConfig, *debug: false*);
```
Nested button presses
---------------------
You may nest button presses like so:
```javascript
    buttonConfig = {
        buttonName: {
            pins: {light: LED_Pin_Number_Here, button: Button_Pin_Number_Here},
            do: Your_Function_Here,
            delay: 1000,
            buttonName2: {
                pins: {light: LED_Pin_Number_Here, button: Button_Pin_Number_Here},
                do: Your_Function_Here
            }
        }
    }
```
You can use nested buttons to greatly increase the possible actions from a limited set of buttons. The delay is the amount of time you have to press the next button after the first button is pressed. Only the last action in a chain of nested button presses is performed.
