Slack = require('slack-node')
config = require('./config')

slack = new Slack(config.slackApiToken)

leavingWork = () ->
	slack.api 'chat.postMessage',
		username: 'Button'
		text:'Pushed a button!'
		channel:'#skunkworks'
	, (err, response) ->
		console.log err, response

arrivingAtWork = () ->
	slack.api 'chat.postMessage',
		username: 'Button'
		text: "Just arrived at work"
		channel:'#skunkworks'
	, (err, response) ->
		console.log err, response

lunchTime = (where) ->
	if where
		message = 'Lunch at ' + where + '?'
	else
		message = 'Lunch time!'

	slack.api 'chat.postMessage',
		username: 'Button'
		text: message
		channel:'#skunkworks'
	, (err, response) ->
		console.log err, response

funnyGif = () ->
	console.log 'funnyGif'

coffeeTime = () ->
	console.log 'coffeeTime'

comboAction = () ->
	console.log 'comboAction'

buttonConfig =
	red:
		pins: {light: 17, button: 6}
		do: leavingWork
		blue:
			do: comboAction
	green:
		pins: {light: 19, button: 5}
		do: arrivingAtWork
	blue:
		pins: {light: 13, button: 8}
		do: funnyGif
	yellow:
		pins: {light: 26, button: 9}
		do: lunchTime
		delay: 1000
		red:
			pins: {light: 17, button: 6}
			do: () ->
				lunchTime('Brown Chicken Brown Cow')
		green:
			pins: {light: 19, button: 5}
			do: () ->
				lunchTime('Super Duper Burger')
		blue:
			pins: {light: 13, button: 8}
			do: () ->
				lunchTime('Edwardo\'s')
		yellow:
			pins: {light: 26, button: 9}
			do: () ->
				lunchTime('Adelita\'s')
		white:
			pins: {light: 22, button: 7}
			do: () ->
				lunchTime('Whole Foods')
	white:
		pins: {light: 22, button: 7}
		do: coffeeTime

buttonsWork = require('./../src/buttons-work').init(buttonConfig, true)

buttonsWork.simulateButtonPress('green')