//
//  AttachmentViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 04/01/1443 AH.
//

import UIKit
import UniformTypeIdentifiers
import PDFKit
class AttachmentViewController: UIViewController {
    
    @IBOutlet weak var nextBtn: PrimaryButton!
    @IBOutlet weak var attachmentLable: UILabel!
    
    @IBOutlet weak var nextLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var attachmentTitleLable: UILabel!
    let documentsPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.png,UTType.jpeg, UTType.pdf],asCopy: true)
    
    let obj = AttachmentModel()
    let viewModel = AttachmentViewModel()

    let vc = UIImagePickerController()
    var correpondenceTypeId = Int()
    var correspondenceId = String()
    var extention = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        
       
        
        
        obj.correspondenceId = "37/1442"
        obj.correspondenceTypeId = 3

        //viewModel.att()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        documentsPicker.delegate = self
        documentsPicker.allowsMultipleSelection = false
        documentsPicker.modalPresentationStyle = .fullScreen
        attachmentTitleLable.font = UIFont.jFFlatRegular(fontSize: 22)
        nextLable.font = UIFont.jFFlatRegular(fontSize: 18)
        setupViewModel()
       
    }
    
    
    //MARK: - SetUp ViewModel
    
    func setupViewModel() {
    
//        viewModel.presentViewController = { [unowned self] (vc) in
//            self.present(vc, animated: true, completion: nil)
//           // self.navigationController?.pushViewController(vc, animated: true)
//        }
        
      
        viewModel.attachArray = { [unowned self] (optionArray) in
           print(optionArray)
            print(optionArray)
        }
        
        viewModel.reloadTableView    = { [unowned self]  in

           self.tableView.reloadData()
          //  refreshControl.endRefreshing()
       }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    class func initializeFromStoryboard() -> AttachmentViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.CreateCorrespondence, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: AttachmentViewController.self)) as! AttachmentViewController
    }

    @IBAction func takePhoto(_ sender: Any) {
        present(vc, animated: true)
        
        
    }
    @IBAction func uploadFile(_ sender: Any) {
       present(documentsPicker, animated: true, completion: nil)
    }
    
    @IBAction func nextAction(_ sender: Any) {
       
        
    }
   
}
extension AttachmentViewController : UINavigationControllerDelegate {
    
}

extension AttachmentViewController : UIImagePickerControllerDelegate{
    // Image picker from Gallery
        func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
            picker.dismiss(animated: true, completion: nil)
           // profileImage.image = image

        }
    // Image Picker from Camera
//
//       func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        picker.dismiss(animated: true, completion: nil)
//
//       }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        

        let image = (info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage)!
        let imageData: Data? = image.jpegData(compressionQuality: 0.4)
        obj.mimType = mimeType(for: imageData!)
        let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
        obj.fileContentEncoded = imageStr
         print(imageStr)
        picker.dismiss(animated: true)
        let vc = FileNameViewController.initializeFromStoryboard()
        vc.delegate = self
        present(vc, animated: true, completion: nil)

    }
     func mimeType(for data: Data) -> String {

        var b: UInt8 = 0
        data.copyBytes(to: &b, count: 1)

        switch b {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x4D, 0x49:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
}
extension AttachmentViewController: UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {return}
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        do{
        let fileData = try Data.init(contentsOf: sandboxFileURL)
            obj.mimType = mimeType(for: fileData)
            extention =  mimeType(for: fileData).components(separatedBy: "/").last!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        let fileStream:String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            obj.fileContentEncoded = fileStream
          //  print("ghadir :  \(fileStream)")
        }catch{
                print("Error : \(error)")
            }
        controller.dismiss(animated: true)
        let vc = FileNameViewController.initializeFromStoryboard()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }

}
extension AttachmentViewController:returnDocumentTitleDelegate{
    func DocumentTitle( text: String) {
        print(text)
        if text != "" {
            obj.documentTitle = text
            obj.correspondenceId = "37/1442" //correspondenceId
            obj.correspondenceTypeId = 3 //correpondenceTypeId
            obj.fileName = text + "." + extention
            print(obj)
            print(obj)
            viewModel.addAttachment(Model: obj)
            
           
        }
        tableView.reloadData()
    }
}

//correspondenceId = "37/1442";
//correspondenceTypeId = 3;


// MARK:- UITableViewController DataSource

extension AttachmentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if viewModel.attachmentModel.count > 0 {
          //  tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }else{
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No_Attachement_available".localized
            noDataLabel.font = UIFont.jFFlatRegular(fontSize: 18)
            noDataLabel.textColor     = UIColor.MoamalatDarkGray
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return viewModel.attachmentModel.count
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentTableViewCell", for: indexPath) as! AttachmentTableViewCell
        
        let obj = viewModel.attachmentModel[indexPath.row]
        cell.documentTitleLable.text = obj.fileName!
        cell.byValue.text = obj.modifiedBy
        cell.sizeValue.text = obj.size
        cell.editDateValue.text = obj.modificationDate
        cell.numvalue.text = obj.versionNo
        
        return cell
    }


}


//MARK:- UITableViewController Delegate

extension AttachmentViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = viewModel.attachmentModel[indexPath.row]
        viewModel.downloadAttachment(filenetDocumentId: obj.filenetDocumentId!)
//        let pdfView = PDFView(frame: self.view.bounds)
//        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.view.addSubview(pdfView)
//        // Fit content in PDFView.
//        pdfView.autoScales = true
//        
//        // Load Sample.pdf file from app bundle.
//        let fileURL = Bundle.main.url(forResource: "Sample", withExtension: "pdf")
//        pdfView.document = PDFDocument(url: fileURL!)
    }

}
