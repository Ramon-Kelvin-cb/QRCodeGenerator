import Foundation
import CoreImage

//Processo de conversão:
//String -> Data -> CIImage -> PNGData (Data)

///Generates a CIImage? QRCode based on a String
func generateQRcode(dados: String) -> CIImage? {
    // Criação de um filtro para código QR
    guard let filtroQR:CIFilter = CIFilter(name: "CIQRCodeGenerator") else {
        print("This filter isn't avaliable")
        return nil
        }

    // Configuração dos dados a serem codificados
    let dadosEmNSData: Data? = dados.data(using: String.Encoding.utf8)
    filtroQR.setValue(dadosEmNSData, forKey: "inputMessage")

    // Obtém a imagem do filtro
    guard let ciImage:CIImage = filtroQR.outputImage else { return nil }

    return ciImage
}

///Increases the size of a CIImage?
func increaseImageSize(of image:CIImage?) -> CIImage? {
    if let myImage:CIImage = image {
        return myImage.transformed(by: .init(scaleX: 100, y: 100))
    } else {
        return nil
    }
}

///Converts your CIImages into PNG data for further use
func createPNGData(image: CIImage?) -> Data? {
    let context:CIContext = CIContext()

    if let myDATA:Data = context.pngRepresentation(of: image ?? .empty(),
                                                   format: .ARGB8,
                                                   colorSpace: CGColorSpaceCreateDeviceRGB()) {
        return myDATA
    } else {
        return nil
    }
}

///Writes your PNG data into your documents folder
func saveToArchives(data: Data?, name: String) {
    if let documentsDirectory:URL = FileManager.default.urls(for: .documentDirectory,
                                                             in: .userDomainMask).first {
    
    // Caminho completo do arquivo PNG
    let arquivoURL:URL = documentsDirectory.appendingPathComponent(name)
    
    // Tentar salvar a imagem como um arquivo PNG
    if let imageData:Data = data {
        do {
            try imageData.write(to: arquivoURL)
            print("Imagem salva com sucesso em \(arquivoURL.path)")
        } catch {
            print("Erro ao salvar a imagem como PNG: \(error.localizedDescription)")
        }
    }
}
}

//Order of execution
//Declares the string
//Use the String into the generateQRcode function
//Use the result into the increaseImageSize function
//Create the PNG data in the createPNGData function]

//The file is being saved into the Documents folder in the saveToArchives function
