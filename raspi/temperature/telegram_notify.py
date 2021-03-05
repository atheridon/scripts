import requests
import time

def telegram_bot_sendtext(bot_message):
	bot_token = '988560744:AAFF8ZASMdbkN-Wn-sEi30Ys33hByqtUu88'
	bot_chatID = '850609041'
	send_text = 'https://api.telegram.org/bot' + bot_token + '/sendMessage?chat_id=' + bot_chatID + '&parse_mode=Markdown&text=' + bot_message
	
	response = requests.get(send_text)
	
	return response.json()

def getMessage():
	tempFile = open("/home/pi/scripts/temperature/notify_temperature.txt", "r")
	msg_text = tempFile.read()
	tempFile.close()

	return msg_text

telegram_bot_sendtext(getMessage())
