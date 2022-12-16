//
//  AcronymViewModel.swift
//  AcronymsFinder
//

import Foundation

protocol AcronymSearchViewModelProtocol{
    
    func getAcronymSearchDetails(searchText:String)
}

class AcronymViewModel:NSObject{
    
    var acronymSearchAPI:AcronymSearchAPI = AcronymSearchAPI ()
    var reloadTableView: (()->())?
    var viewModelDataSource:[DataListCellViewModel] = [DataListCellViewModel](){
        didSet {
            self.reloadTableView?()
        }
    }
    
    //To get acronyms for searchtext
    func getAcronymSearchDetails(searchText:String){
        
        if ConnectionManager.sharedInstance.checkNetworkAvailability() == true{
                        
            self.acronymSearchAPI.getAcronymSearchDetails(searchText: searchText) { acronymModel in
                            
                guard let acronym = acronymModel.last else {
                    
                    self.viewModelDataSource.removeAll()
                    self.reloadTableView?()
                    return
                }
                self.createDataSource(datas: acronym)
                
            } CompletionFail: { response in
                
                switch response{
                    
                case .failure(let error):
                    Utilities.showError(error: error)
                    break
                    
                case .statusCode(let code):
                    Utilities.showAlertMessage(statusCode: code)
                    break
                    
                case .errorMessage(_):
                    
                    break
                }
            }
        }
    }
    
    //To create data source for ViewModel
    func createDataSource(datas:Acronym){
        
        if viewModelDataSource.count > 0{
            viewModelDataSource.removeAll()
        }
        
        if let lfs = datas.lfs{
            
            var dataList = [DataListCellViewModel]()
            
            for lf in lfs{
                
                if let lfValue = lf.lf{
                                        
                    dataList.append(DataListCellViewModel(titleText: lfValue))
                }
            }
            viewModelDataSource = dataList
        }
        self.reloadTableView?()
    }
    
    //To get the number of rows count
    var numberOfCells: Int {
        return viewModelDataSource.count
    }
    
    //To get celldata for showing in Tableview
    func getCellViewModel( at indexPath: IndexPath ) -> DataListCellViewModel {
        if indexPath.row < viewModelDataSource.count {
            return viewModelDataSource[indexPath.row]
        }
        else
        {
            return DataListCellViewModel(titleText: "")
        }
    }
    
    struct DataListCellViewModel {
        let titleText: String
    }
}
