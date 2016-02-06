buttonConfig = 
	red:
		pins: {light: 19, button: 5}
		do: () ->
			console.log 'action ran'

buttonsWork = require('../src/buttons-work').init(buttonConfig)

buttonsWork.simulateButtonPress('red')