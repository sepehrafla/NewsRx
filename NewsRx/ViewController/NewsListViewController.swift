//
//  ViewController.swift
//  NewsRx
//
//  Created by Sepehr Aflatounian on 2022-01-10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NewsListViewController: UIViewController {
    private var articles = [Article]()
    let disposeBage = DisposeBag()
    
    lazy var titleLable: UILabel = {
        let label = UILabel()
        label.text = "News"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupview()
        populateNews()
        // Do any additional setup after loading the view.
    }
    private func populateNews(){
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=6d1c913a9cff427da937eec5bbac9f24")!
        Observable.just(url)
            .flatMap{url->Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map{data -> [Article]? in
                return  try? JSONDecoder().decode(ArticlesList.self, from: data).articles
            }.subscribe(onNext: {[weak self] articles in
                if let articles = articles {
                    self?.articles = articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBage)
    }
    
    func setupview () {
        view.addSubview(titleLable)
        titleLable.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(1)
            make.centerX.equalToSuperview()
        }
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.rowHeight = 250
        tableView.snp.makeConstraints{make in
            make.top.equalTo(titleLable.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(5)
        }
    }


}
extension NewsListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else{
            fatalError("Article Does Not Exist")
        }
        cell.titleLabel.text = self.articles[indexPath.row].title
        cell.descriptionLabel.text = self.articles[indexPath.row].description
        let imageurl = self.articles[indexPath.row].urlToImage ?? "https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg"
        let url = URL(string: imageurl)
        let data = try? Data(contentsOf: url!)
        cell.labelImageView.image = UIImage(data: data!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
}
