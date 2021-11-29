//
//  ActionViewController.swift
//  ActionExtension
//
//  Created by kimhyungyu on 2021/11/29.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {

    // MARK: - Properties
    
    var text: String?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var myTextView: UITextView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // ✅ extensionContext : Returns the extension context of the view controller. NSExtensionContext
        // ✅ inputitems : The list of input NSExtensionItem objects associated with the context. NSExtensionItem
        // ✅ attachments : An optional array of media data associated with the extension item. [NSItemProvider]?
        guard let textItem = self.extensionContext?.inputItems.first as? NSExtensionItem,
              let textItemProvider = textItem.attachments?.first else { return }
        // ✅ hasItemConformingToTypeIdentifier(_:) : item provider 에 지정된 UIT(파일 및 데이터 전송을 위한 유형 식별자) 를 준수하는 데이터 표현이 포함되어 있는지 여부를 나타내는 Boolean 값 리턴.
        if textItemProvider.hasItemConformingToTypeIdentifier(UTType.text.identifier) {
            textItemProvider.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { item, error in
                self.text = item as? String
                
                DispatchQueue.main.async {
                    self.myTextView.text = self.text
                }
            }
        }
        
        
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        
        // 🪓 example code.
        /*
        var imageFound = false
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! {
                if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                    // This is an image. We'll load it, then place it in our image view.
                    weak var weakImageView = self.imageView
                    provider.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil, completionHandler: { (imageURL, error) in
                        OperationQueue.main.addOperation {
                            if let strongImageView = weakImageView {
                                if let imageURL = imageURL as? URL {
                                    strongImageView.image = UIImage(data: try! Data(contentsOf: imageURL))
                                }
                            }
                        }
                    })

                    imageFound = true
                    break
                }
            }

            if (imageFound) {
                // We only handle one image, so stop looking for more.
                break
            }
        }
        */
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        
        let returnItemProvider = NSItemProvider(item: myTextView.text as NSSecureCoding?, typeIdentifier: UTType.text.identifier)
        let returnItem = NSExtensionItem()
        
        returnItem.attachments = [returnItemProvider]
        self.extensionContext?.completeRequest(returningItems: [returnItem], completionHandler: nil)
    }

}
