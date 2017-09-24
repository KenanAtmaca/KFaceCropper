# KFaceCropper
İOS 11 Vision Api. Image Face Cropper 💇🏻‍♂️

![alt tag](https://user-images.githubusercontent.com/16580898/30782452-4779ff1a-a13b-11e7-8a92-e57414034e06.png)

## Advantages
- [X] Simply use.
- [X] Fast.
- [X] Less code.

#### Use

```Swift
       cropper = KFaceCropper(image: imgVV.image!)
       cropper.crop()
```

##### Get Faces and Result types

```Swift
       cropper.getFaces { (faces, type) in
            switch type {
            case .success:
                self.imgs = faces
            case .failed(let fail): print(fail)
            case .error(let error):
                print(error)
            }
        }
```

##### Faces Count

```Swift
       cropper.count
```
