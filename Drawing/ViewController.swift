//
//  ViewController.swift
//  Drawing
//
//  Created by aycan duskun on 4.01.2023.
//

import UIKit
import PencilKit
import PhotosUI

class ViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {

    
    
    @IBOutlet weak var pencilButton: UIBarButtonItem!
    
    @IBOutlet weak var canvasView: PKCanvasView!
    
    let canvasWidth: CGFloat = 350
    let canvasOverScrollHeight: CGFloat = 500
    let drawing = PKDrawing()
    let toolPicker = PKToolPicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.drawing = drawing
        canvasView.delegate = self
        canvasView.alwaysBounceVertical = true
        canvasView.drawingPolicy = .anyInput
        
        }
    
    
   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

       
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let canvasScale = canvasView.bounds.width / canvasWidth
        canvasView.minimumZoomScale = canvasScale
        canvasView.maximumZoomScale = canvasScale
        canvasView.zoomScale = canvasScale
        
        updateContentSizeForDrawing()
        canvasView.contentOffset = CGPoint(x: 0, y: -canvasView.adjustedContentInset.top)
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool{
        return true
    }
    
    @IBAction func fingerOrPencil (_ sender: Any) {
        canvasView.allowsFingerDrawing.toggle()
        pencilButton.title = canvasView.allowsFingerDrawing ? "Finger" : "Pencil"
        
    }
    
    
    @IBAction func saveToCameraRoll(_ sender: Any) {
        
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            }, completionHandler: {success, error in
            
            })
        }
    }
    
    
    
    func updateContentSizeForDrawing() {
        let drawing = canvasView.drawing
        let contentHeight: CGFloat
        
        if !drawing.bounds.isNull {
            contentHeight = max(canvasView.bounds.height, (drawing.bounds.maxY + self.canvasOverScrollHeight) * canvasView.zoomScale)
        } else {
            contentHeight = canvasView.bounds.height
        }
        canvasView.contentSize = CGSize(width: canvasWidth * canvasView.zoomScale, height: contentHeight)
    }
    
    // Delegate Methods
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
       updateContentSizeForDrawing()
      
    }
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        
    }
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        
    }
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        
    }
}

