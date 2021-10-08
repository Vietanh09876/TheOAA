
import UIKit

class EvaluationCardViewController: UIViewController {
    //MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContainerView: UIView!
    
    var previousCell: Int = 0
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewConfig()
        TableViewConfig()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        previousCell = 0
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeightConstraint.constant = 1000
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }
    
    private func viewConfig() {
        self.view.backgroundColor = .clear
        scrollContainerView.backgroundColor = .clear
        
        userImage.contentMode = .scaleAspectFill
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = UIColor(red: 0.16, green: 0.26, blue: 0.13, alpha: 1.00).cgColor
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.image = UIImage(named: "Unknown_person")
        
        scrollView.backgroundColor = .clear
    }
    
    private func TableViewConfig() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.register(UINib(nibName: "EvaluationCardCell", bundle: nil), forCellReuseIdentifier: "EvaluationCardCell")
    }
    
    private func setupLayout() {
        userImage.topAnchor.constraint(equalTo: scrollContainerView.topAnchor, constant: 25 + 55).isActive = true
        userImage.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 55 * 7 + 25).isActive = true
        userImage.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: self.view.bounds.width/2.5).isActive = true
    }
    
    
}


//MARK: - TableView DataSource, Delegate
extension EvaluationCardViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 6
        case 2:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "EvaluationCardCell", for: indexPath) as! EvaluationCardCell
        Cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            if indexPath.row % 2 == 0 {
                Cell.cellImage.image = UIImage(named: "im_EvaluationCell")
            }
            else {
                Cell.cellImage.image = UIImage(cgImage: (UIImage(named: "im_EvaluationCell")?.cgImage)!, scale: 1, orientation: .downMirrored)
            }
        case 1:
            if indexPath.row % 2 == 0 {
                Cell.cellImage.image = UIImage(cgImage: (UIImage(named: "im_EvaluationCell")?.cgImage)!, scale: 1, orientation: .downMirrored)
            }
            else {
                Cell.cellImage.image = UIImage(named: "im_EvaluationCell")
            }
        case 2:
            print("nani")
            Cell.titleLabel.text = "why"
            Cell.commentTextView.isHidden = false
            Cell.contentView.bringSubviewToFront(Cell.commentTextView)
        default:
            return UITableViewCell()
        }
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    //MARK: Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "THPT"
        case 1:
            return "Đánh Giá"
        case 2:
            return "Nhận Xét Của Giáo Viên"
        default:
            return "?"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 0.12, green: 0.55, blue: 0.27, alpha: 1.00)
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}

//if previousCell % 2 == 0 {
//    print("even\n")
//    Cell.cellImage.image = UIImage(named: "im_EvaluationCell")
//}
//
//
//else if previousCell == 7 {
//    print("7\n")
//    Cell.cellImage.image = UIImage(cgImage: (UIImage(named: "im_EvaluationCell")?.cgImage)!, scale: 1, orientation: .downMirrored)
//    Cell.titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
//    Cell.contentLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
//}
//
//else if previousCell == 9 {
//    print("9\n")
//    Cell.commentTextView.isHidden = false
//    Cell.contentView.bringSubviewToFront(Cell.commentTextView)
//}
//
//else {
//    print("odd\n")
//    Cell.cellImage.image = UIImage(cgImage: (UIImage(named: "im_EvaluationCell")?.cgImage)!, scale: 1, orientation: .downMirrored)
//}
//
//
//
//previousCell += 1
//
