//
//  RecipeViewPresenter .swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 30/11/2021.
//

import Foundation
import CoreData
import ObjectMapper

let appdelegate = UIApplication.shared.delegate as? AppDelegate

protocol RecipeListViewProtocol : BaseViewProtocol {
    func noMoreData()
    func RecipeRetrieved(list: [Hit])
    func SearchRetrieved(list: [SearchTokens])
    
}

class RecipeListViewPresenter : BaseViewPresenter {
    
    private var dataSource: RecipeModel?
    private var wordsDataSource = [SearchTokens]()
    private var delegate : RecipeListViewProtocol!
    private var service = RecipeService()
    private var searchText : String?
    
    
    
    init(delegate : RecipeListViewProtocol) {
        self.delegate = delegate
    }
    
    
    override func viewIsReady () {
        super.viewIsReady()
        self.resetViewData()
        self.delegate.showNoDataView(message: "Welcome to recipe food App you can Search for any recipe ")
    }
    
    private func resetViewData(){
        dataSource = nil
        
    }
    
    
    func pullToRefresh()  {
        if let search = searchText  , !search.isEmpty {
            self.resetViewData()
            self.geetRecipeList(searchText: search , from:  (dataSource?.from)!, to: (dataSource?.to)!)
        }
    }
    
    
    func loadMoreData (){
        guard let value_to = dataSource?.to , let value_total = dataSource?.count else {
            return
        }
        
        if value_to < value_total {
            dataSource?.from = (dataSource?.hits?.count)!
            dataSource?.to = (dataSource?.from)! + 10
            
            self.geetRecipeList(searchText: searchText!, from:  (dataSource?.from)!, to: (dataSource?.to)!)
        }else{
            delegate.noMoreData()
        }
    }
    
    func geetRecipeList(searchText : String , from: Int  , to : Int ){
        self.delegate.showLoadingView()
        service.getRecipeList(searchText: searchText, from: from, to: to) { response in
            self.dataSource = response
            self.delegate.hideLoadingView()
            self.delegate.RecipeRetrieved(list: (self.dataSource?.hits)!)
            
        } failure: {
            self.delegate.hideLoadingView()
        }
    }
    func userEditingSearchText( searchText: String ){
        saveSearchText(searchText: searchText)
        for i in 0..<wordsDataSource.count {
            
            if ((wordsDataSource[i].word?.caseInsensitiveCompare(searchText)) == .orderedSame) {
                
                deleteWord(index: i)
                break
            }
        }
        self.geetRecipeList(searchText: searchText, from:  (dataSource?.from)!, to: (dataSource?.to)!)
        
    }
    
    func userDidBeginEditingSearchText(){
        if fetchLatestWord() != 0 {
            delegate.SearchRetrieved(list: wordsDataSource)
        }
    }
}

extension RecipeListViewPresenter {
    func saveSearchText(searchText:String){
        
        if fetchLatestWord() == 20 {
            deleteWord(index: 0)
        }
        
        if #available(iOS 10.0, *) {
            guard let entity  = appdelegate?.persistentContainer.viewContext else {return}
            let seaarchWord = SearchTokens(context: entity)
            seaarchWord.word = searchText
            print(seaarchWord)
            do {
                try entity.save()
            } catch  {
                print(error)
            }
        } else {
            let context = NSEntityDescription.insertNewObject(forEntityName: "SearchTokens", into: appdelegate!.managedObjectContext)
            context.setValue(searchText, forKey: "word")
            do {
                try context.managedObjectContext!.save()
            } catch  {
                print(error)
            }
        }
    }
    func fetchLatestWord() -> Int{
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchTokens")
        
        if #available(iOS 10.0, *) {
            guard let entity  = appdelegate?.persistentContainer.viewContext else { return Int()}
            do {
                wordsDataSource =  try entity.fetch(fetchrequest) as! [SearchTokens]
                print(wordsDataSource.count)
                print(wordsDataSource)
            } catch  {
                print(error)
            }
        } else {
            
            let context = appdelegate?.managedObjectContext
            do {
                wordsDataSource = try context!.fetch(fetchrequest) as! [SearchTokens]
            } catch  {
                print(error)
            }
        }
        return wordsDataSource.count
    }
    func deleteWord(index : Int){
        if  index < wordsDataSource.count {
            let note = wordsDataSource[index]
            if #available(iOS 10.0, *) {
                let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                managedContext.delete(note)
                wordsDataSource.remove(at: index)
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Error While Deleting Note: \(error.userInfo)")
                }
            } else {
                let context = appdelegate?.managedObjectContext
                context?.delete(wordsDataSource[index] as NSManagedObject)
                wordsDataSource.remove(at: index)
                do {
                    try context?.save()
                } catch  {
                    print(error)
                }
            }
        } else {
            
            // show alert
            
        }
    }
}
