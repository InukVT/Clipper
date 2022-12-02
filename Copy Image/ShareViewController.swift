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
            let imageType = "public.image"
            guard let item = self.extensionContext?.inputItems[0] as? NSExtensionItem,
                  let attachments = item.attachments,
                  let first = attachments.first,
                  first.registeredTypeIdentifiers.contains(imageType),
                  let image = try? await first.loadItem(forTypeIdentifier: imageType),
                  let nsImage = image as? NSImage else
            {
                // TODO: Better handling
                let cancelError = NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownError, userInfo: nil)
                self.extensionContext!.cancelRequest(withError: cancelError)
                return
            }
            
            self.data = nsImage.tiffRepresentation
            imageView?.image = nsImage
        }
    }

    @IBAction func send(_ sender: AnyObject?) {
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
