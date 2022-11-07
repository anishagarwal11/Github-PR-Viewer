//
//  ViewController.swift
//  practice45
//
//  Created by Anish Agarwal on 05/11/22.
//

import UIKit

class ClosePRListViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    
    var loader = Loader()
    var viewModel: ViewModelDataSource = ClosePRListViewModel(NetworkManger.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupViewModel()
    }
    
    func setupViewController() {
        productTableView.register(UINib(nibName: ClosedPRTableViewCell.className, bundle: Bundle.main), forCellReuseIdentifier: ClosedPRTableViewCell.className)
        DispatchQueue.main.async {
            self.loader.showLoader(self)
        }
        viewModel.getDataFromServer()
    }
    
    func setupViewModel() {
        
        viewModel.updateUI = {
            DispatchQueue.main.async { [weak self] in
                self?.loader.hideLoader()
                self?.productTableView.reloadData()
            }
        }
        
        viewModel.showAlert = { [weak self] errorType in
            self?.loader.hideLoader()
            switch errorType {
                case .apiFailed:
                self?.showAlertView(titleString: Constants.AlertConstants.Title.apiFailureTitle, messageString: Constants.AlertConstants.Message.apiFailureMessage, actionString: Constants.AlertConstants.AlertAction.okAction)
                case .decodingError:
                self?.showAlertView(titleString: Constants.AlertConstants.Title.decodingErrorTitle, messageString: Constants.AlertConstants.Message.decodingErrorMessage, actionString: Constants.AlertConstants.AlertAction.okAction)
            case .custom(let error):
                self?.showAlertView(titleString: "Error 404", messageString: error.localizedDescription, actionString: Constants.AlertConstants.AlertAction.okAction)
            case .statusCodeError(let statusCode):
                self?.showAlertView(titleString: "Error \(statusCode)", messageString: Constants.AlertConstants.Message.apiFailureMessage, actionString: Constants.AlertConstants.AlertAction.okAction)
            }
        }
        
        viewModel.allDataFetchedShowMessage = { [weak self] in
            DispatchQueue.main.async {
                self?.productTableView.tableFooterView = self?.createCompletedFooterView()
            }
        }
          
    }
    
    func createLoaderFooter() -> UIView {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        
        return footerView
    }
    
    func createCompletedFooterView() -> UIView {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        label.text = Constants.TableViewHeaderFooterLabels.FooterLabelMessage.allDataFetchedFooter
        label.center = footerView.center
        label.textAlignment = .center
        footerView.addSubview(label)
        
        return footerView
    }
    
}

extension ClosePRListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: ClosedPRTableViewCell.className, for: indexPath) as? ClosedPRTableViewCell
        let data = viewModel.getRowData(rowIndex: indexPath.row)
        cell?.setupCell(data: data)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.TableViewHeaderFooterLabels.HeaderLabelMessage.listOfPRHeader
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (productTableView.contentSize.height - 100 - scrollView.frame.size.height)
        {
            DispatchQueue.main.async {
                self.productTableView.tableFooterView = self.createLoaderFooter()
            }
            viewModel.getMoreDataFromServer()
        }
    }
    
}



