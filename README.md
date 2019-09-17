# Image-processing and Computer Vision

## Image Demosaicing 
* The current imaging sensors are not capable of recording the wavelengths of all colors equally at each sensor location. Hence, we use the color filter array (CFA) to capture a particular wavelength at a given sensor. Typically, the CFAs have three distinct types of filters named Red (R), Green (G) and Blue (B) - each of which is most sensitive to a particular range of wavelengths. Thus, image demosaicing is the process of recovering the missing two colors’ information at each sensor location thereby obtaining the R, G, B values at each pixel. The two types of demosaicing techniques used here are:
  * Demosaicing through bilinear interpolation
  * Malvar-He-Cutler (MHC) demosaicing
  
### Results
<img src="demosaicing/example_demosaicing.jpg">
  
 
