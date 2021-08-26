//
//  MenuViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 23/12/1442 AH.
//

    
    import UIKit

    class MenuViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

        @IBOutlet weak var userImage: UIImageView!
        @IBOutlet weak var DeptLable: UILabel!
        @IBOutlet weak var userName: UILabel!
        @IBOutlet weak var tableView: UITableView!
        
        var menuOptions = ["my_correspondence".localized,"sent_correspondence".localized,"search".localized ,"settings".localized,"logout".localized]
      
        override func viewDidLoad() {
            super.viewDidLoad()
   
        //   makeRounded()
          lableAttributes()
            self.revealViewController()?.rightViewRevealWidth = (self.view.frame.size.width) * 0.75
        }
        
//        func makeRounded() {
//            userImage.layer.borderWidth = 1
//            userImage.layer.masksToBounds = false
//            userImage.layer.borderColor = UIColor.black.cgColor
//            userImage.layer.cornerRadius = userImage.frame.height / 2
//            userImage.clipsToBounds = true
//
//            }
//
        func lableAttributes()  {

            userName.font = UIFont(name: Fonts.JFFlatRegular, size: 25)
            userName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            DeptLable.font = UIFont(name: Fonts.JFFlatRegular, size: 17)
            DeptLable.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return menuOptions.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuCell
            
            cell.menuImage.image = UIImage(named: menuOptions[indexPath.row])
            cell.MenuLable.font = UIFont(name: Fonts.JFFlatRegular, size: 20)
            
            cell.MenuLable.text = menuOptions[indexPath.row]
           
            
            let view = UIView()
            view.backgroundColor =  UIColor(red: 92.0/255, green: 0/255, blue: 213/255, alpha: 1.0)
            cell.selectedBackgroundView = view
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if menuOptions[indexPath.row] == "search".localized {
                let vc = SearchViewController.initializeFromStoryboard()
                let navigationController = UINavigationController(rootViewController: vc)
                navigationController.modalTransitionStyle = .crossDissolve
                navigationController.modalPresentationStyle = .overFullScreen
                navigationController.setViewControllers([vc], animated:true)
                self.revealViewController()?.pushFrontViewController(navigationController, animated: true)
                //setFront(navigationController, animated: true)
               // present(navigationController, animated: true, completion: nil)
            }else if menuOptions[indexPath.row] == "my_correspondence".localized{
                let vc = InboxViewController.initializeFromStoryboard()
                let navigationController = UINavigationController(rootViewController: vc)
                navigationController.modalTransitionStyle = .crossDissolve
                navigationController.modalPresentationStyle = .overFullScreen
                navigationController.setViewControllers([vc], animated:true)
                self.revealViewController()?.pushFrontViewController(navigationController, animated: true)
            }else if menuOptions[indexPath.row] == "logout".localized {
                let vc = LogoutViewController.initializeFromStoryboard()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
             present(vc, animated: true, completion: nil)
  
            } else if menuOptions[indexPath.row] == "sent_correspondence".localized{
                let vc = SentCorrespondenceViewController.initializeFromStoryboard()
                let navigationController = UINavigationController(rootViewController: vc)
                navigationController.modalTransitionStyle = .crossDissolve
                navigationController.modalPresentationStyle = .overFullScreen
                navigationController.setViewControllers([vc], animated:true)
                self.revealViewController()?.pushFrontViewController(navigationController, animated: true)
            }
        }

        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.selectionStyle = .none
            cell.selectedBackgroundView = UIView() // optional
            cell.selectedBackgroundView?.backgroundColor = .MoamalatLightBlue // optional
        }
           }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


