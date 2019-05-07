<?php
$password="";
if(isset($argv))
{
  array_shift($argv);

    foreach ($argv as $arg)
    {
        $password .=$arg." ";
    }
}

$password = rtrim($password," ");
$iterations = 2048;
$salt="mnemonic";
$hash = hash_pbkdf2("sha512", $password, $salt, $iterations);
echo $hash;

