buttonConfig =
	green:
		pins: {button: 19}
		do: () ->
			console.log 'Pressed a button!'

buttonsWork = require('./../src/buttons-work').init(buttonConfig, true)