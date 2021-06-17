//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Lorand Fazakas on 2021. 06. 14..
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (()-> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
