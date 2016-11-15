#!/bin/env php
# mail some stuff with php

<?php
$to      = '';
$subject = '';
$message = '';
$headers = 'From: ' . "\r\n" .
	    		 'Reply-To: ' . "\r\n" .
			     'X-Mailer: PHP/' . phpversion();

mail($to, $subject, $message, $headers);
?>
