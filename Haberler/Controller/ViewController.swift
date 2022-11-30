import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var arr = [Article]()
    var refresh = UIRefreshControl()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! TableViewCell
        cell.headLabel.text = arr[indexPath.row].title
        if(arr[indexPath.row].urlToImage==nil){
            print("hata!")
        }else{
            cell.photoview.loadFrom(from: arr[indexPath.row].urlToImage!)
        }
        return cell
    }
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refresh)
        
        getCity()
        
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: kontrol)
        timer.fire()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueIdentifier"{
            let vc = segue.destination as! HaberDetayViewController
            vc.imageURL = arr[tableView.indexPathForSelectedRow!.row].urlToImage!
            vc.label = arr[tableView.indexPathForSelectedRow!.row].content!
            
        }
    }
    private func kontrol(t : Timer){
        if(arr.count>0){
            tableView.reloadData()
            t.invalidate()
            
        }
    }
    
    func getCity(){
        NetworkManager.instance.fetch(HTTPMethod.get, url: "https://newsapi.org/v2/top-headlines?country=tr&apiKey=ab3e4696199842848e887411209d8804" , requestModel: nil, model: HaberModel.self ) { response in
            
            switch(response)
            {
            case .success(let model):
                let haberModel = model as! HaberModel
                self.arr = haberModel.articles
                
                
            case .failure(_): break
            }
        }
    }
}

