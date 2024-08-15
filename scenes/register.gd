extends Control

@onready var http = $HTTPRequest
@onready var ConfigLoader = load("res://shared/configLoader.gd").new()
@onready var config = ConfigLoader.load_config()
@onready var serverUrl = config.httpServer

func _ready(): 
	http.request_completed.connect(_on_request_completed)
	
func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)

func _on_submit_pressed():
	var loginPanel = $MarginContainer/VBoxContainer/Login
	var emailPanel = $MarginContainer/VBoxContainer/Email
	var passwordPanel = $MarginContainer/VBoxContainer/Password
	var password2Panel = $MarginContainer/VBoxContainer/Password2
	
	var validation = _validate_credentials(loginPanel.text, emailPanel.text, passwordPanel.text, password2Panel.text)
	if validation:
		print(validation)
		return
	
	_send(JSON.stringify({"login": loginPanel.text, "email": emailPanel.text, "password": passwordPanel.text}))
	
	loginPanel.text = ""
	emailPanel.text = ""
	passwordPanel.text = ""
	password2Panel.text = ""

func _validate_credentials(login: String, email: String, password: String, password2: String):
	if login.length() < 3:
		return "Login incorrect"
	if(!email.contains("@")):
		return "Incorrect email"
	if(password != password2):
		return "Passwords are not the same"

func _send(body: String):
	http.request(serverUrl, ["Content-Type: application/json"], HTTPClient.METHOD_POST, body)
