
import UIKit

class Indicator: UIActivityIndicatorView {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate 
    
    required init(coder aDecoder: NSCoder){
        fatalError("use init(")
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
    }
    
    func loadingView(_ isloading: Bool) {
        if isloading {
            self.startAnimating()
        } else {
            self.stopAnimating()
            self.hidesWhenStopped = true
            
        }
    }
    
}

extension UdacityNetwork {
    
    func logout(_ controller: UIViewController) {
        controller.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    func addLocation(_ controller: UIViewController) {
        let AlertController = UIAlertController(title: "", message: "User \(appDelegate.firstName) \(appDelegate.lastName) Already Posted A Student Location. Would You Like To Overwrite Their Location?", preferredStyle: .alert)
        let InfoViewController = controller.storyboard!.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        let willOverwriteAlert = UIAlertAction(title: "Overwrite", style: UIAlertActionStyle.default) {
            action in controller.present(InfoViewController, animated: true, completion: nil)
            
       /* let willOverwriteAlert = UIAlertAction(title: "Overwrite", style: UIAlertActionStyle.default) {
                action in
                let navigationController = UINavigationController(rootViewController: InfoViewController)
                controller.present(navigationController, animated: true, completion: nil)
            }*/
        }
       let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
        action in AlertController.dismiss(animated: true, completion: nil)
        }
        
        AlertController.addAction(willOverwriteAlert)
       AlertController.addAction(cancelAction)
        
        
        if (UIApplication.shared.delegate as! AppDelegate).willOverwrite {
            controller.present(AlertController, animated:true, completion: nil)
        } else {
            controller.present(InfoViewController, animated: true, completion: nil)
        }
    }
    
    //Navigation
    
    func navigateTabBar(_ controller: UIViewController) {
        let TabBarController = controller.storyboard!.instantiateViewController(withIdentifier: "TabBarMapController") as! UITabBarController
        controller.present(TabBarController, animated: true, completion: nil)
    }
    
    func checkURL(_ url: String) -> Bool {
        if let url = URL(string: url) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
}

    //Error Messages

struct ErrorMessage {
    let DataError = "Error Getting Data!"
    let MapError = "Failed To Geocode!"
    let UpdateError = "Failed To Update Location!"
    let InvalidLink = "Invalid Link!"
    let MissingLink = "Need To Enter Link!"
    let CantLogin = "Network Connection Is Offline!"
    let InvalidEmail = "Invalid Email Or Password!"

    }


extension UdacityNetwork {
    
   func alertError(_ controller: UIViewController, error: String) {
       let AlertController = UIAlertController(title: "", message: error, preferredStyle: .alert)
       let cancelAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
            action in AlertController.dismiss(animated: true, completion: nil)
        }
      AlertController.addAction(cancelAction)
       controller.present(AlertController, animated: true, completion: nil)
    }
    
}

class addLocationDelegate: NSObject, UITextFieldDelegate {
    
    override init() {
        
        super.init()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
}
