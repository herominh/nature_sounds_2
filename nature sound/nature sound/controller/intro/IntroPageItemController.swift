import UIKit
import SnapKit

class IntroPageItemController: UIViewController {

    var imageName = "untitle"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let imageBg = UIImage(named: imageName)
        let imageView = UIImageView(image: imageBg)
        imageView.contentMode = .scaleAspectFit
        
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints{(make)-> Void in
            make.top.equalToSuperview().offset(30)
            make.bottom.left.right.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
