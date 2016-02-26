Gpio = require('onoff').Gpio

debug = false
actions = null
lights = {}
buttons = {}
buttonTimeout = null
currentAction = null
debounce = {}

setButton = (name, value) ->
	if lights[name]
		lights[name].write(value)

buttonPressed = (name) ->
	if debug
		console.log name + ' button pressed'

	if buttonTimeout
		clearTimeout(buttonTimeout)

	if debounce[name]
		return

	# If we're pressing another button, and there is a command mapped to the button combination, then overwrite currentAction
	if currentAction and currentAction[name]
		currentAction = currentAction[name]
	else
		currentAction = actions[name]

	if debug
		console.log currentAction
		
	buttonTimeout = setTimeout () ->
		debounce[name] = true
		currentAction.do()
		currentAction = null
		buttonTimeout = null
	, currentAction.delay or 0

initializePins = () ->
	console.log 'opening pins'
	for name, buttonConfig of actions
		if buttonConfig.pins
			if buttonConfig.pins.light
				lights[name] = new Gpio(buttonConfig.pins.light, 'out')
				if debug
					console.log 'opening light pin ' + buttonConfig.pins.light
			
			buttons[name] = new Gpio(buttonConfig.pins.button, 'in', 'both')
			if debug
				console.log 'opening button pin ' + buttonConfig.pins.button
			buttons[name].watch ((name, err, value) ->
				if value and !buttonTimeout
					setButton(name, 1)
					buttonPressed(name)
				else if !value
					debounce[name] = false
					setButton(name, 0)
			).bind(this, name)

module.exports = 
	init: (buttonConfig, enableDebug) ->
		if enableDebug
			debug = true
		actions = buttonConfig
		initializePins()
		return this
	simulateButtonPress: (buttonName) ->
		buttonPressed(buttonName)

# Close pins on shutdown

process.stdin.resume()

exitHandler = (options, err) ->
	console.log 'closing pins'
	for light in lights
		light.unexport()
	for button in buttons
		button.unexport()
	process.exit()

process.on 'exit', exitHandler.bind(null, {cleanup: true})
process.on 'SIGINT', exitHandler.bind(null, {exit: true})
process.on 'uncaughtException', exitHandler.bind(null, {exit: true})