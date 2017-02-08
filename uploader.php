<?php

/*
 * @Name: Uploader.
 * @Description: Retrieves a file and stores it on the web server and returns a public URL.
 * @Date: 08/02/2017
 * @Author: Daniel Phillips - github.com/cradev
 * @Credit: Highly inspired by: https://github.com/csexton/captured-php
 */


class Uploader 
{
	const API_TOKEN = 'change me'; // API Token used to authenticate requests.
	const UPLOAD_DIR = 's/'; // The path to where to store the file.

	private $length;

	public function __construct()
	{
		
		$this->length = 5; // length of the random filename.
		
	}

	private function echoJSON($arr)
	{
		// Return a JSON string.
		echo json_encode($arr, JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);
	}

	private function randomString()
	{
		// create a random string according to $length.
		$chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$string = '';

		for($i = 0; $i < $this->length; $i++) {
			$string .= $chars[mt_rand(0, strlen($chars) -1)];
		}

		return $string;

	}

	private function joinPaths() {
	 	$paths = array();
	 	foreach (func_get_args() as $arg) {
			if ($arg !== '') { $paths[] = $arg; }
	 	}
		return preg_replace('#/+#','/',join('/', $paths));
	}

	public function enforceToken()
	{
		// Check whether the token matches, if not, throw 401.
		if($_POST['token'] != SELF::API_TOKEN){
			http_response_code(401);
			$this->echoJSON(['status' => "401 invalid token"]);
			exit();
		}
	}

	private function procesFileUpload()
	{
		// upload the file to the server and return the public URL.

		header('Content-Type: application/json');
		$protocol= (empty($_SERVER['HTTPS'])) ? 'http://' : 'https://';
		$ext = pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);
		$upload_name = $this->randomString() . '.' . $ext;
		$upload_file = $this->joinPaths(SELF::UPLOAD_DIR, $upload_name);
		$public_url = $protocol . $_SERVER['SERVER_NAME'] . "/uploader/" . $upload_name;

		if (move_uploaded_file($_FILES['file']['tmp_name'], $upload_file)) {
			$this->echoJSON(["public_url" => $public_url]);
		} else {
			$this->echoJSON(['error' => "Unable to process file upload"]);
		}
	}

	public function main()
	{
		$this->enforceToken();
		$this->procesFileUpload();
	}
}

$uploader = new Uploader();
$uploader->main();