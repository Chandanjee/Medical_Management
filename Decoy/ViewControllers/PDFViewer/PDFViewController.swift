//
//  PDFViewController.swift
//  Decoy
//
//  Created by MAC on 04/12/21.
//

import UIKit
import PDFKit
import MBProgressHUD

class PDFViewController: UIViewController {
//    var pdfView = PDFView()
        var pdfURL: URL!
    private let document: PDFDocument! = nil
    private let outline: PDFOutline? = nil
    private var pdfView = PDFView()
    var titleData = ""
//    let pdfViewController = PDFViewController()
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var pdfFile:UIView!

//    init(pdfUrl: URL) {
//         self.pdfURL = pdfUrl
//         self.document = PDFDocument(url: pdfUrl)
//         self.outline = document.outlineRoot
//         pdfView.document = document
//         super.init(nibName: nil, bundle: nil)
//     }
//    required init?(coder aDecoder: NSCoder) {
//          fatalError("init(coder:) has not been implemented")
//      }
    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showAdded(to: self.view, animated: true)

        titleLabel.text = titleData
        if let document = PDFDocument(url: pdfURL) {
                  pdfView.document = document
            MBProgressHUD.hide(for: self.view, animated: true)

              }
        self.pdfFile.addSubview(pdfView)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func tapTOback(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapToDownload(_ sender:Any){
        guard let url = pdfURL else { return }
                
                let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
                
                let downloadTask = urlSession.downloadTask(with: url)
                downloadTask.resume()
        
        
//        let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
//        Alamofire.download(.GET, "https://httpbin.org/stream/100", destination: destination)
     
      
        

    }
    override func viewDidLayoutSubviews() {
           pdfView.frame = view.frame
       }
}

extension PDFViewController:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            print("downloadLocation:", location)
            // create destination URL with the original pdf name
            guard let url = downloadTask.originalRequest?.url else { return }
            let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
            // delete original copy
            try? FileManager.default.removeItem(at: destinationURL)
            // copy from temp to Document
            do {
                try FileManager.default.copyItem(at: location, to: destinationURL)
                self.pdfURL = destinationURL
            } catch let error {
                print("Copy Error: \(error.localizedDescription)")
            }
        }
    }
}
