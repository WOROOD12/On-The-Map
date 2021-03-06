

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Table View Data
    
    var indicator = Indicator()
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func refreshButton(_ sender: Any) {
        
        indicator.loadingView(true)
        loadTableView()
    }
    @IBAction func addLocation(_ sender: Any) {
        
        UdacityNetwork.sharedInstance().addLocation(self)
    }
    @IBAction func logoutButton(_ sender: Any) {
       // let controller;
      //self.dismiss(animated: true, completion: nil)
        
        UdacityNetwork.sharedInstance().logoutID()
        self.dismiss(animated: true, completion: nil)
         self.navigationController?.pushViewController(tabBarController!, animated: true)
        
    }
    
    override func viewDidLoad() {
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        indicator.loadingView(true)
        loadTableView()
        print(tableView(tableView, numberOfRowsInSection: 100))
    }
    
    func loadTableView() {
        
        UdacityNetwork.sharedInstance().getUsersData {(success, error) in
            
            if success {
                DispatchQueue.main.async {
              //   self.dismiss(animated: true, completion: nil)
                    self.tableView.reloadData()
                  // self.indicator.loadingView(false)
                   // self.dismiss(animated: true, completion: nil)
                }
                
            } else {
                
                self.indicator.stopAnimating()
                
                UdacityNetwork.sharedInstance().alertError(self, error: self.appDelegate.errorMessage.DataError)
            }
        }
    }
    
    //Table View Data Info
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if usARR.UsersArray.count<100 {
            return usARR.UsersArray.count
        }
        else {
            
            return 100
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell")!
        let user = usARR.UsersArray[indexPath.row]
        
        
        infoCell.textLabel?.text = "\(user.firstName) \(user.lastName)"
        infoCell.imageView?.image = UIImage(named: "pin")
        infoCell.detailTextLabel?.text = user.mediaURL
        
        return infoCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = usARR.UsersArray[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        let app = UIApplication.shared
        if UdacityNetwork.sharedInstance().checkURL(user.mediaURL){
            app.openURL(URL(string: user.mediaURL)!)
        } else {
            UdacityNetwork.sharedInstance().alertError(self, error: self.appDelegate.errorMessage.InvalidLink)
        }
        
        
    }
    
    
}
