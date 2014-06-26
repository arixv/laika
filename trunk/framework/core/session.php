<?php

class Session {
    private static $started=false;


    public static function Start() {
    	HTTPContext::Start(true);
        /*
        ini_set('session.only_cookies',true);
        session_start();
        self::$started=true;
        */
    }

    public static function Set($key, $value)
    {
        HTTPContext::Set($key, $value);
        /*
        if (!self::$started)
            self::start();
        $_SESSION[$key]=$value;
        */
    }

   public static function Get($key)
   {
        return HTTPContext::Get($key);
        /*if (!self::$started)
            self::start();
        if(isset($_SESSION[$key]))
        	return $_SESSION[$key];
        else
        	return false;*/
    }

   public static  function Delete($key)
   {
        HTTPContext::Delete($key);
        /*if (!self::$started)
            self::start();
        if(isset($_SESSION[$key]))
        	unset($_SESSION[$key]);*/
    }

    public static function Clean()
    {
        HTTPContext::Clean();
    }

    public static function Destroy()
    {
        HTTPContext::Destroy();
    }

    public static function Close()
    {
        HTTPContext::Close();
    }

    /*public static function getvalues(){
		return($_SESSION);
    }*/

}