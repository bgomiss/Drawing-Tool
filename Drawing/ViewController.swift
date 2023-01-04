//
//  ViewController.swift
//  Drawing
//
//  Created by aycan duskun on 4.01.2023.
//

import UIKit
import PencilKit

class ViewController: UIViewController, PKCanvasViewDelegate {

    private let canvasView: PKCanvasView = {
       
       let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput
        return canvas
    }()
    
    let drawing = PKDrawing()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.drawing = drawing
        canvasView.delegate = self
        view.addSubview(canvasView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        canvasView.frame = view.bounds
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let toolPicker = PKToolPicker()
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        
    }
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        
    }
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        
    }
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        
    }
}

