<?php
class MimePart
{
	const OctetStream = 'application/octet-stream';
	const Text = 'text/plain';
	const HTML = 'text/html';
	const MultipartMixed = 'multipart/mixed';
	const MultipartRelated = 'multipart/related';
	const MultipartAlternative = 'multipart/alternative';
	
	const QuotedPrintableEncoding = 'quoted-printable';
	const Base64Encoding = 'base64';
	const Bit7Encoding = '7bit';
	
	const AttachmentDisposition = 'attachment';
	const InlineDisposition = 'inline';
	
	const LineLength = 75;
	const EOL = "\r\n";
	
	protected $_Type = null;
	protected $_Encoding = null;
	protected $_Id = null;
	protected $_Disposition = null;
	protected $_Filename = null;
	protected $_Charset = null;
	protected $_Content = null;
	protected $_Headers = null;
	protected $_Parts = array();
	protected $_Boundary = null;
	
	protected function __construct()
	{
		$this->_Id =  md5(microtime(true) . getmypid() . rand());
		$this->_Boundary = '=_' . $this->_Id;
	}
	
	public function AddPart(MimePart $mimePart)
    {
        $this->_Parts[] = $mimePart;
    }
    
    public function AddParts(array $mimeParts)
    {
    	foreach ($mimeParts as $mimePart)
    	{
    		$this->AddPart($mimePart);
    	}
    }
    
	protected function SetContent($content)
	{
		$this->_Content = $content;
	}
    
    protected function SetType($type)
	{
		$this->_Type = $type;
	}
	
	protected function SetEncoding($encoding)
	{
		$this->_Encoding = $encoding;
	}
	
	protected function SetDisposition($disposition)
	{
		$this->_Disposition = $disposition;
	}
	
	protected function SetCharset($charset)
	{
		$this->_Charset = $charset;
	}
	
	protected function SetFilename($filename)
	{
		$this->_Filename = $filename;
	}
	
	public function GetId()
	{
		return $this->_Id;
	}
	
	public static function CreateMultipartMixed()
	{
		$mimePart = new MimePart();
		$mimePart->SetType(self::MultipartMixed);
		
		return $mimePart;
	}
	
	public static function CreateMultipartAlternative()
	{
		$mimePart = new MimePart();
		$mimePart->SetType(self::MultipartAlternative);
		
		return $mimePart;
	}
	
	public static function CreateMultipartRelated()
	{
		$mimePart = new MimePart();
		$mimePart->SetType(self::MultipartRelated);
		
		return $mimePart;
	}
	
	public static function CreateHTML($content, $charset)
	{
		$mimePart = new MimePart();
		$mimePart->SetEncoding(self::QuotedPrintableEncoding);
		$mimePart->SetType(self::HTML);
		$mimePart->SetCharset($charset);
		$mimePart->SetContent($content);
		
		return $mimePart;
	}
	
	public static function CreateText($content, $charset)
	{
		$mimePart = new MimePart();
		$mimePart->SetEncoding(self::QuotedPrintableEncoding);
		$mimePart->SetType(self::Text);
		$mimePart->SetCharset($charset);
		$mimePart->SetContent($content);
		
		return $mimePart;
	}
	
	public static function CreateAttachment($content, $filename, $type)
	{
		$mimePart = new MimePart();
		$mimePart->SetDisposition(self::AttachmentDisposition);
		$mimePart->SetEncoding(self::Base64Encoding);
		$mimePart->SetContent($content);
		$mimePart->SetFilename($filename);
		$mimePart->setType($type);
		
		return $mimePart;
	}
	
	public static function CreateImage($content, $type)
	{
		$mimePart = new MimePart();
		$mimePart->SetDisposition(self::InlineDisposition);
		$mimePart->SetEncoding(self::Base64Encoding);
		$mimePart->SetContent($content);
		$mimePart->SetType($type);
		
		return $mimePart;
	}
	
	public function GetContent()
	{
		return $this->GetHeaders() . self::EOL . $this->GetBody();
	}
	
	protected function GetHeaders()
	{
		$res = 'Content-Type: ' . $this->_Type;
		
		if (count($this->_Parts))
		{
			$res .= ';' . self::EOL . "\t" . 'boundary="' . $this->_Boundary . '"' . self::EOL; 
		}
		elseif ($this->_Charset)
		{
			$res .= '; charset="' . $this->_Charset . '"';
		}
		
		if ($this->_Encoding)
		{
			$res .= self::EOL . 'Content-Transfer-Encoding: ' . $this->_Encoding . self::EOL;
		}
		
		if ($this->_Disposition == self::InlineDisposition) 
		{
			$res .= 'Content-ID: <' . $this->_Id . '>' . self::EOL;
		}
		
		if ($this->_Disposition) 
		{
			$res .= 'Content-Disposition: ' . $this->_Disposition;
			if ($this->_Filename) 
			{
				$res .= '; filename="' . $this->_Filename . '"';
			}
			$res .= self::EOL;
		}
		
		return $res;
	}
	
	protected function GetBody()
	{
		if (count($this->_Parts))
		{
            $boundary = $this->_Boundary;

            $body = '';
            $first = true;
            foreach ($this->_Parts as $part)
            {
            	$body .= '--' . $boundary . self::EOL;
            	$body .= $part->GetContent();
            }
            $body .= '--' . $boundary . '--' . self::EOL;
		}
		else
		{
			$body = self::Encode($this->_Content, $this->_Encoding, self::LineLength, self::EOL) . self::EOL;
		}
		
		return $body;
	}
	
	/**
	 * Encoding functions below
	 */
	
	static public $_QpKeysString = 
		"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1A\x1B\x1C\x1D\x1E\x1F\x7F\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8A\x8B\x8C\x8D\x8E\x8F\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9A\x9B\x9C\x9D\x9E\x9F\xA0\xA1\xA2\xA3\xA4\xA5\xA6\xA7\xA8\xA9\xAA\xAB\xAC\xAD\xAE\xAF\xB0\xB1\xB2\xB3\xB4\xB5\xB6\xB7\xB8\xB9\xBA\xBB\xBC\xBD\xBE\xBF\xC0\xC1\xC2\xC3\xC4\xC5\xC6\xC7\xC8\xC9\xCA\xCB\xCC\xCD\xCE\xCF\xD0\xD1\xD2\xD3\xD4\xD5\xD6\xD7\xD8\xD9\xDA\xDB\xDC\xDD\xDE\xDF\xE0\xE1\xE2\xE3\xE4\xE5\xE6\xE7\xE8\xE9\xEA\xEB\xEC\xED\xEE\xEF\xF0\xF1\xF2\xF3\xF4\xF5\xF6\xF7\xF8\xF9\xFA\xFB\xFC\xFD\xFE\xFF";

	public static function IsPrintable($string)
	{
		return (strcspn($string, self::$_QpKeysString) == strlen($string));
	}
	
	public static function EncodeQuotedPrintable($string)
	{
		return self::Encode($string, self::QuotedPrintableEncoding, self::LineLength, self::EOL);
	}
	
	public static function EncodeBase64($string)
	{
		return self::Encode($string, self::Base64Encoding, self::LineLength, self::EOL);
	}
	
	public static function Encode($string, $encoding, $lineLength = null, $lineEnd = null)
	{
		switch ($encoding)
		{
			case self::Base64Encoding:
				$encoding = 'convert.base64-encode';
				break;

			case self::QuotedPrintableEncoding:
				$encoding = 'convert.quoted-printable-encode';
				break;
		}
		
		$fp = fopen('php://temp/', 'r+');
		
		$params = array();
		if ($lineEnd && $lineLength)
		{
			$params = array('line-length' => $lineLength, 'line-break-chars' => $lineEnd);
		}
		
		stream_filter_append($fp, $encoding, STREAM_FILTER_WRITE, $params);
		fputs($fp, $string);
		rewind($fp);
		
		return stream_get_contents($fp);
	}
}
?>