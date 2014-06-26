<?php
class Image {
	
	public $gdresource; 
	public $type;
	// Release resources 
	public function __destruct()
	{
		if ($this->gdresource) {
			imagedestroy($this->gdresource);
		}
	}

	// Load an image from a file 
	public function load($file)
	{
		// Get image mimetype 
		$size = getimagesize($file); 
		$this->type = $size['mime'];

		// Load image based on type
		switch ($this->type)
		{
			case 'image/jpeg': 
				$this->gdresource = imagecreatefromjpeg($file);
				break;
			case 'image/png': 
				$this->gdresource = imagecreatefrompng($file); 
				//imagealphablending($this->gdresource, true); // setting alpha blending on
				break;
			case 'image/gif': 
				$this->gdresource = imagecreatefromgif($file); 
				break;
		}
		imagesavealpha($this->gdresource, true); // Retain the alpha information
	}

	// Save the file to the local filesystem 
	public function save($filePath, $quality=100)
	{
		switch ($this->type) {
			case 'image/jpeg': 
				imagejpeg($this->gdresource, $filePath . '.jpg', $quality); 
				break;
			case 'image/png': 
				imagepng($this->gdresource, $filePath  . '.png'); 
				break;
			case 'image/gif': 
				// Convert back to palette 
				if (imageistruecolor($this->gdresource)) {
					imagetruecolortopalette($this->gdresource, false, 256);
				} 
				imagegif($this->gdresource, $filePath . '.gif'); 
				break;
		}
	}
	
	// Display the image in the browser 
	public function display()
	{
		switch ($this->type)
		{
			case 'image/jpeg': 
				header("Content-type: image/jpeg"); 
				imagejpeg($this->gdresource, null, 100); 
				break;
			case 'image/png': 
				header("Content-type: image/png"); 
				imagepng($this->gdresource); 
				break;
			case 'image/gif': 
				// Convert back to palette 
				if (imageistruecolor($this->gdresource))
				{
					imagetruecolortopalette($this->gdresource, false, 256);
				}
				header("Content-type: image/gif"); 
				imagegif($this->gdresource); 
			break;
		}
	}

	// Resize the image 
	public function resize()
	{
		$ir = new ImageResize();
		switch (func_num_args()) {
			case 1: 
				$ir->ratio = func_get_arg(0); 
				break;
			case 2: 
				$ir->max_width = func_get_arg(0); 
				$ir->max_height = func_get_arg(1); 
				break;
		}
		// Perform the resize 
		$this->gdresource = $ir->process($this->gdresource);
	}

	// Crop the image 
	public function crop($width, $height)
	{
		$ic = new ImageCrop();
		$ic->width  = $width; 
		$ic->height = $height; 
		$this->gdresource = $ic->process($this->gdresource);
	}

	// Custom Crop the image 
	public function customcrop($pos_x,$pos_y,$custom_width,$custom_height,$width,$height)
	{
		$ic = new ImageCustomCrop();
		$ic->pos_x         = $pos_x;
		$ic->pos_y         = $pos_y;
		$ic->custom_width  = $custom_width;
		$ic->custom_height = $custom_height;
		$ic->width         = $width;
		$ic->height        = $height;
		$this->gdresource  = $ic->process($this->gdresource);
	}

	public function rotate($degrees)
	{
		$ir = new ImageRotate();
		$ir->rotation = $degrees;
		$this->gdresource = $ir->process($this->gdresource);
	}

	// Add a caption to the image
	public function caption($text, $font, $size = null, $padding = null, $drawline = null)
	{
		$ic = new ImageCaption();
		// Set size, padding, line if needed 
		if($size)
		{
			$ic->fontsize = $size;
		} 
		if($padding !== null)
		{
			$ic->padding = $padding;
		} 
		if($drawline !== null)
		{
			$ic->drawline = $drawline;
		}
		// Set font, caption 
		$ic->fontfile = $font; 
		$ic->caption = $text;
		// Perform the captioning 
		$this->gdresource = $ic->process($this->gdresource);
	}
	
	public function logo($logofile, $loc_x = null, $loc_y = null, $padding = null, $ratio = null)
	{
		$il = new ImageLogo();

		// Set logo file 
		$il->logofile = $logofile;
		
		// Set location, padding, and ratio if needed 
		if ($loc_x !== null)
		{
			$il->location['x'] = $loc_x;
		}
		if($loc_y !== null)
		{
			$il->location['y'] = $loc_y;
		}
		if($padding !== null)
		{
			$il->padding = $padding;
		}
		if($ratio !== null)
		{
			$il->ratio = $ratio;
		}
		
		// Perform the logo placement 
		$this->gdresource = $il->process($this->gdresource);
	}
	
}
?>
