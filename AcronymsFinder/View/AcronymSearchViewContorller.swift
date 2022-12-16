//
//  AcronymSearchViewContorller.swift
//  AcronymsFinder
//
//

import UIKit

class AcronymSearchViewContorller: UIViewController {
    
    @IBOutlet weak var noAcronymsFoundLabel: UILabel!
    @IBOutlet weak var acronymSearchTableview: UITableView!
    @IBOutlet weak var acronymSearchTextfield: UITextField!
    var viewModelProtocol:AcronymSearchViewModelProtocol?
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    var dataViewModel:AcronymViewModel = AcronymViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.acronymSearchTableview.dataSource = self
        self.acronymSearchTextfield.delegate = self
        self.initViewModel()
    }
    
    //To initalise ViewModel
    func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.acronymSearchTableview.reloadData() }
        }
    }
    
    //To show No data available message when no acronym found
    func showNoDataAvailable(cellCount:Int){
        
        (cellCount >= 1) ? (self.noAcronymsFoundLabel.isHidden = true) :(self.noAcronymsFoundLabel.isHidden = false)
        
    }
    
    //Debouncing implementation
    func debounceAcronymSearch(searchString:String){
        
        pendingRequestWorkItem?.cancel()
        let requestWorkItem = DispatchWorkItem { [weak self] in                        self!.dataViewModel.getAcronymSearchDetails(searchText: searchString)
        }
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: requestWorkItem)
        
    }
}

//Extension for UITableViewDataSource methods
extension AcronymSearchViewContorller:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        showNoDataAvailable(cellCount: dataViewModel.numberOfCells)
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.customTableViewCell, for: indexPath) as? CustomTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        let cellViewModel = dataViewModel.getCellViewModel( at: indexPath )
        cell.dataLabel.text = cellViewModel.titleText
        return cell
    }
}

//Extension for UITextFieldDelegate methods
extension AcronymSearchViewContorller:UITextFieldDelegate{
    
    //UITextFieldMethods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.autocorrectionType = .no
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let characterSet = NSCharacterSet(charactersIn: CharactersSet.characterSet).inverted
        let filteredSet = string.components(separatedBy: characterSet).joined(separator: "")
        
        var textFieldString = String()
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            textFieldString = String(textField.text?.dropLast() ?? "")
        }
        else {
            textFieldString = "\(textField.text ?? "")\(string)"
        }
        
        if string == filteredSet{
            
            debounceAcronymSearch(searchString: textFieldString)
        }
        return string == filteredSet
    }
}
