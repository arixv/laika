<?php
class Captcha {
	
	/* Captcha */
	public static function getCaptchaValue()
	{
		$captcha = rand(1,36).'-'.rand(1,36).'-'.rand(1,36).'-'.rand(1,36).'-'.rand(1,36);
		return $captcha;
	}
	
	
	
	public static function valueFromNumbers($captchavalue)
	{
		$numbers = explode('-', $captchavalue);

		$captcha  = self::valueFromRandom($numbers[0]);
		$captcha .= self::valueFromRandom($numbers[1]);
		$captcha .= self::valueFromRandom($numbers[2]);
		$captcha .= self::valueFromRandom($numbers[3]);
		$captcha .= self::valueFromRandom($numbers[4]);

		return $captcha;

	}

	public static function valueFromRandom($num)
	{
		if(is_numeric($num)):
			switch($num)
			{
				case "1": $ran = "a"; break;
				case "2": $ran = "b"; break;
				case "3": $ran = "c"; break;
				case "4": $ran = "d"; break;
				case "5": $ran = "e"; break;
				case "6": $ran = "f"; break;
				case "7": $ran = "g"; break;
				case "8": $ran = "h"; break;
				case "9": $ran = "i"; break;
				case "10": $ran = "j"; break;
				case "11": $ran = "k"; break;
				case "12": $ran = "l"; break;
				case "13": $ran = "m"; break;
				case "14": $ran = "n"; break;
				case "15": $ran = "o"; break;
				case "16": $ran = "p"; break;
				case "17": $ran = "q"; break; 
				case "18": $ran = "r"; break; 
				case "19": $ran = "s"; break; 
				case "20": $ran = "t"; break; 
				case "21": $ran = "u"; break; 
				case "22": $ran = "v"; break; 
				case "23": $ran = "w"; break; 
				case "24": $ran = "x"; break; 
				case "25": $ran = "y"; break; 
				case "26": $ran = "z"; break; 
				case "27": $ran = "0"; break; 
				case "28": $ran = "1"; break; 
				case "29": $ran = "2"; break; 
				case "30": $ran = "3"; break; 
				case "31": $ran = "4"; break; 
				case "32": $ran = "5"; break; 
				case "33": $ran = "6"; break; 
				case "34": $ran = "7"; break; 
				case "35": $ran = "8"; break; 
				case "36": $ran = "9"; break;
			}
			return $ran;
		else:
			return false;
		endif;
	}

	public static function assign_rand_value($num)
	{
	  switch($num)
	  {
	    case "1":
	     $rand_value = "a";
	    break;
	    case "2":
	     $rand_value = "b";
	    break;
	    case "3":
	     $rand_value = "c";
	    break;
	    case "4":
	     $rand_value = "d";
	    break;
	    case "5":
	     $rand_value = "e";
	    break;
	    case "6":
	     $rand_value = "f";
	    break;
	    case "7":
	     $rand_value = "g";
	    break;
	    case "8":
	     $rand_value = "h";
	    break;
	    case "9":
	     $rand_value = "i";
	    break;
	    case "10":
	     $rand_value = "j";
	    break;
	    case "11":
	     $rand_value = "k";
	    break;
	    case "12":
	     $rand_value = "l";
	    break;
	    case "13":
	     $rand_value = "m";
	    break;
	    case "14":
	     $rand_value = "n";
	    break;
	    case "15":
	     $rand_value = "o";
	    break;
	    case "16":
	     $rand_value = "p";
	    break;
	    case "17":
	     $rand_value = "q";
	    break;
	    case "18":
	     $rand_value = "r";
	    break;
	    case "19":
	     $rand_value = "s";
	    break;
	    case "20":
	     $rand_value = "t";
	    break;
	    case "21":
	     $rand_value = "u";
	    break;
	    case "22":
	     $rand_value = "v";
	    break;
	    case "23":
	     $rand_value = "w";
	    break;
	    case "24":
	     $rand_value = "x";
	    break;
	    case "25":
	     $rand_value = "y";
	    break;
	    case "26":
	     $rand_value = "z";
	    break;
	    case "27":
	     $rand_value = "0";
	    break;
	    case "28":
	     $rand_value = "1";
	    break;
	    case "29":
	     $rand_value = "2";
	    break;
	    case "30":
	     $rand_value = "3";
	    break;
	    case "31":
	     $rand_value = "4";
	    break;
	    case "32":
	     $rand_value = "5";
	    break;
	    case "33":
	     $rand_value = "6";
	    break;
	    case "34":
	     $rand_value = "7";
	    break;
	    case "35":
	     $rand_value = "8";
	    break;
	    case "36":
	     $rand_value = "9";
	    break;
	  }
	return $rand_value;
	}
	
	
	
	
	
	
}



?>