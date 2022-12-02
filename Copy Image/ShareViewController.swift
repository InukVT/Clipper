//
//  ShareViewController.swift
//  Copy Image
//
//  Created by Bastian Inuk Christensen on 2022-12-02.
//

import Cocoa

class ShareViewController: NSViewController {

    override var nibName: NSNib.Name? {
        return NSNib.Name("ShareViewController")
    }
    
    @IBOutlet weak var imageView: NSImageView?
    
    var data: Data? = nil

    override func loadView() {
        super.loadView()
        Task {
            let item = self.extensionContext!.inputItems[0] as! NSExtensionItem
            guard let attachments = item.attachments else {
                NSLog("No Attachments")
                return
            }
            let imageType = "public.image"
            NSLog("Attachments = %@", attachments as NSArray)
            guard let first = attachments.first,
                  first.registeredTypeIdentifiers.contains(imageType) else {
                
                return
            }
            
            do {
                let image = try await first.loadItem(forTypeIdentifier: imageType)
                if let nsImage = image as? NSImage {
                    imageView?.image = nsImage
                    
                    self.data = nsImage.tiffRepresentation;
                }
            } catch {
                print (error)
            }
        }
    }

    @IBAction func send(_ sender: AnyObject?) {
        let outputItem = NSExtensionItem()
        // Complete implementation by setting the appropriate value on the output item
    
        let outputItems = [outputItem]
        
        if let data = data {
            let pasteType = NSPasteboard.PasteboardType.tiff
            NSPasteboard.general.declareTypes([pasteType], owner: nil)
            assert( NSPasteboard.general.setData(data, forType: pasteType), "Error!")
        }
        
        self.extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
}

    @IBAction func cancel(_ sender: AnyObject?) {
        let cancelError = NSError(domain: NSCocoaErrorDomain, code: NSUserCancelledError, userInfo: nil)
        self.extensionContext!.cancelRequest(withError: cancelError)
    }

}
