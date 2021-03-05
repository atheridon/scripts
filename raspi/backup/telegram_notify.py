import requests
import time


def telegram_bot_sendtext(bot_message):
	bot_token = '988560744:AAFF8ZASMdbkN-Wn-sEi30Ys33hByqtUu88'
	bot_chatID = '850609041'
	send_text = 'https://api.telegram.org/bot' + bot_token + '/sendMessage?chat_id=' + bot_chatID + '&parse_mode=Markdown&text=' + bot_message
	
	response = requests.get(send_text)
	
	return response.json()

def getMessage():
	tempFile = "notify_backup.txt"

	readFile = open(tempFile, "r")
	msg_text = readFile.read()
	readFile.close()

	open(tempFile, "w").close()

	return msg_text

telegram_bot_sendtext(getMessage())
