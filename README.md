# QRCodeGenerator
Some functions to help you generate and manage QRCodes in your application.

**This package consists in four basic methods:**

**generateQRcode(String) -> CIImage?**: Translate your string into a QRCode by using some filters of CIImage

**increaseImageSize(CIImage?) -> CIImage?**: Increase the resolution of your QRCode

**createPNGData(CIImage?) -> Data?** : Converts your CIImage in Data to use in your services

**saveToArchives(Data?, String) -> Void** : Write your Data (creates a PNG) on your Documents folder
