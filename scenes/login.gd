extends Control

@onready var http = $HTTPRequest
@onready var Config_loader = load("res://shared/configLoader.gd").new()
@onready var config = Config_loader.load_config()
@onready var server_url = config.httpServer
@onready var client_secret = config.clientSecret
@onready var client_id = config.clientId
@onready var redirect_url = config.redirectUrl
@onready var auth_server = server_url + "/auth"
@onready var token_server = server_url + "/token"

var redirect_server = TCPServer.new()
var redirect_uri = "http://127.0.0.1:3005/login"
var token
var refresh_token
var code_verifier

func _ready():
	http.request_completed.connect(_on_request_completed)
	set_process(false)
	get_auth_code()
	
func _process(_delta):
	if redirect_server.is_connection_available():
		var connection = redirect_server.take_connection()
		var req = connection.get_string(connection.get_available_bytes())
		if req:
			set_process(false)
			var auth_code = req.split("&iss")[0].split("code=")[1]
			get_code(auth_code)
			
func _on_request_completed(result, _response_code, _headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	ServerConnection.log_in(json)

func get_auth_code():
	set_process(true)
	
	var redir_err = redirect_server.listen(3005, "127.0.0.1")
	if(redir_err):
		print("Got err while creating server: ", redir_err)
		return
	code_verifier = generate_code_verifier()
	var challenge = generate_code_challenge_from_verifier(code_verifier)

	var body_parts = [
		"client_id=" + client_id,
		"response_type=code",
		"redirect_uri=" + redirect_url,
		"nonce=" + generate_randomName(30),
		"scope=openid",
		"code_challenge_method=S256",
		"code_challenge=" + challenge 
	]
	
	var url = auth_server + "?" + '&'.join(body_parts)
	OS.shell_open(url)

func generate_randomName(amount: int):
	var characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var random_string = ""
	var char_count = characters.length()

	for i in range(amount):
		var random_index = randi() % char_count
		random_string += characters[random_index]

	return random_string

func generate_code_challenge_from_verifier(val: String) -> String:
	var hashed = sha256(val.to_utf8_buffer())
	return base64_url_encode(hashed)

func sha256(data: PackedByteArray) -> PackedByteArray:
	var context = HashingContext.new()
	context.start(HashingContext.HASH_SHA256)
	context.update(data)
	return context.finish()

func base64_url_encode(data: PackedByteArray) -> String:
	var base64_string = Marshalls.raw_to_base64(data)
	base64_string = base64_string.replace("+", "-")
	base64_string = base64_string.replace("/", "_")
	return base64_string.replace("=", "")

func generate_code_verifier() -> String:
	var array = []
	for i in range(28):
		array.append(randi() % 0xFFFFFFFF)
	
	var verifier = ""
	for value in array:
		verifier += dec2hex(value)
	
	return verifier.substr(0, 128)

func dec2hex(dec: int) -> String:
	var hex_string = str(dec, 16).to_upper()
	if hex_string.length() < 2:
		hex_string = "0" + hex_string
	return hex_string


func get_code(code: String):
	var body_parts = [
		"client_id=" + client_id,
		"client_secret=" + client_secret,
		"code=" + code,
		"grant_type=" + "authorization_code",
		"redirect_uri=" + redirect_url,
		"code_verifier=" + code_verifier,
	]
	
	http.request(token_server, ["Content-Type: application/x-www-form-urlencoded"], HTTPClient.METHOD_POST, '&'.join(body_parts))
