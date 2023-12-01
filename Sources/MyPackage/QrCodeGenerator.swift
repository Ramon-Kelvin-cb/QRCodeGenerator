import Foundation
import CoreImage

//Processo de conversão:
//String -> Data -> CIImage -> PNGData (Data)

//Gera um QRCode a partir de uma String (Um QRCode é apenas uma tradução de uma String,
//quem decide o que fazer com a String traduzida é a aplicação)
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

//A imagem ao sair do filtro vem com uma resolução baixa, aqui a imagem é escalada para se obter uma qualidade maior
func increaseImageSize(of image:CIImage?) -> CIImage? {
    if let myImage:CIImage = image {
        return myImage.transformed(by: .init(scaleX: 100, y: 100))
    } else {
        return nil
    }
}

//Converte a CIImage em PNGData (Data) que pode ser salva em arquivo ou até mesmo subida para algum serviço externo
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

//O arquivo está sendo salvo na pasta Documentos com essa função
//Em futuras implementações você poderá escolher onde salvar o arquivo
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

//Ordem de execução:
//Declara a String
//Joga a String na função generateQRCode
//O resultado joga em increaseImageSize
//O resultado joga em createPNGData
//Caso queira, você pode jogar o resultado desse último método em saveToArchive para salvar o PNG resultante

//Atualmente não está havendo uma tratativa de erros, caso em algum momento a função não funcione
//ela simplesmente joga um valor nulo para a próxima etapa
