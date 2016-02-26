var buttonConfig ={
	green: {
		pins: {button: 19},
		do: function () {
			console.log('Pressed a button!');
		}
	}
}

var buttonsWork = require('./../lib/buttons-work').init(buttonConfig, true);