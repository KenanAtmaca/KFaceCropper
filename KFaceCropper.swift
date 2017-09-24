//
//  KFaceCropper
//
//  Copyright © 2017 Kenan Atmaca. All rights reserved.
//  kenanatmaca.com
//
//

import UIKit
import Vision

enum resultType {
    case success
    case failed(String)
    case error(String)
}

@available(iOS 11.0, *)

class KFaceCropper {
   
    private var visionRequests:[VNRequest] = []
    private var faces:[UIImage] = []
    private var rType:resultType!
    
    var image:UIImage!
    
    var count:Int {
        return self.faces.count
    }
    
    init(image:UIImage) {
        self.image = image
    }
    
    func crop() {
        
        let faceReq = VNDetectFaceLandmarksRequest(completionHandler: self.setupHandler)
        self.visionRequests = [faceReq]
        
            let imageRequestHandler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
            
            do {
                try imageRequestHandler.perform(self.visionRequests)
            } catch {
                print(error.localizedDescription)
            }
    }
    
    private func setupHandler(request: VNRequest, errror: Error?) {
        
        guard let observations = request.results as? [VNFaceObservation] else {
            rType = resultType.error((errror?.localizedDescription)!)
            return
        }
        
        if observations.count > 0 {
            rType = resultType.success
            observations.forEach { (face) in
                
                let imgW = image.size.width
                let imgH = image.size.height
                
                let w = face.boundingBox.width * imgW
                let h = face.boundingBox.height * imgH
                let x = face.boundingBox.origin.x * imgW
                let y = (1 - face.boundingBox.origin.y) * imgH - h
                
                let faceRect = CGRect(x: x, y: y, width: w, height: h)
                
                let cgImg = image.cgImage?.cropping(to: faceRect)
                self.faces.append(UIImage(cgImage: cgImg!))
            }
            
        } else {
            rType = resultType.failed("@Faces not dedected.")
        }
    }
    
    func getFaces(completion: @escaping (_ faces:[UIImage],_ type:resultType)->()) {
        
        completion(faces,rType)
    }
    
}//
