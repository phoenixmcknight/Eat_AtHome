import UIKit

class SearchResultViewController: UIViewController {

    let searchResultView = SearchResultView()
    
    var resultURLFilter:URLFilters!
    
    var searchResultViewModel:RecipeViewModel!
    
    var searchQuery:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchResultView)
        setDelegatesToSelf()
        setUpNavigationBar()
        addTargetToButtons()
       
        let request = RecipeRequestParameters.from(urlFilters: resultURLFilter)
        searchResultViewModel = RecipeViewModel(request: request, delegate: self, searchQuery: searchQuery)
        
        
        searchResultViewModel.fetchRecipes()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = searchQuery?.capitalized
    }
    
    private func setDelegatesToSelf() {
        searchResultView.resultCollectionView.delegate = self
        searchResultView.resultCollectionView.dataSource = self
        searchResultView.resultCollectionView.prefetchDataSource = self
    }
    
    private func addTargetToButtons() {
        searchResultView.buttonOne.addTarget(self, action: #selector(sortMethod(sender:)), for: .touchUpInside)
        searchResultView.buttonTwo.addTarget(self, action: #selector(sortMethod(sender:)), for: .touchUpInside)
        searchResultView.buttonThree.addTarget(self, action: #selector(sortMethod(sender:)), for: .touchUpInside)
    }
    
    
    @objc private func navigateToSearchBar()
       {
           navigationItem.titleView = searchResultView.mainSearchRecipeBar
           navigationItem.rightBarButtonItem = nil
       }
    
    
    @objc private func sortMethod(sender:UIButton) {
        searchResultView.customActivityIndictator.startAnimating()
        searchResultViewModel.changeSortMethod(newSortMethod: sortByTag(tag: sender.tag))
        searchResultViewModel.fetchRecipes()
    }
    
    private func sortByTag(tag:Int) -> sortByMethod {
        switch tag {
        case 0:
           return .time
        case 1:
          return .price
        default:
            return .popularity
        }
    }
    
    private func setUpNavigationBar()
       {
           let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(navigateToSearchBar))
           
           
           navigationItem.rightBarButtonItem = barButton
          //change this
           navigationItem.title = "Recipes"
           
           
       }
    
    
}
extension SearchResultViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultViewModel.currentCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViewCells.result.rawValue, for: indexPath) as? SearchResultCollectionViewCell else
        {return UICollectionViewCell()}
        
        if isLoadingCell(for: indexPath) {
            cell.configureCell(with: .none, itemNumber: .none)
        } else {
            cell.delegate = self
            cell.configureCell(with: searchResultViewModel.recipe(at: indexPath.item), itemNumber: indexPath.item)
        }
        return cell
    }
}

extension SearchResultViewController:UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { (indexPath) -> Bool in
            isLoadingCell(for: indexPath)
        }) {
            searchResultView.customActivityIndictator.startAnimating()
            searchResultViewModel.fetchRecipes()
        }
    }
    
    
}

extension SearchResultViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.height * 0.35, height: view.frame.height * 0.35)
       }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
      
}

extension SearchResultViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        searchResultView.customActivityIndictator.startAnimating()
        searchResultViewModel.changeQuery(newQuery:text)
        searchResultView.queryLabel.text = "Search: \(text)"
        searchResultViewModel.fetchRecipes()
            }
        }
    
extension SearchResultViewController:SearchResultCellDelegate {
    func navigateToDetailVC(tag: Int) {
          let detailVC = DetailRecipeViewController()
        
        searchResultView.customActivityIndictator.startAnimating()
        guard let selectedCell = searchResultView.resultCollectionView.cellForItem(at: IndexPath(item: tag, section: 0)) as? SearchResultCollectionViewCell else {return}
              detailVC.recipeImage = selectedCell.foodImageView.image ?? UIImage(named:"Italian")!
        detailVC.recipe = searchResultViewModel.recipe(at: tag)
        searchResultView.customActivityIndictator.stopAnimating()
              navigationController?.pushViewController(detailVC, animated: true)
    }
    
  
    
}

extension SearchResultViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= searchResultViewModel.currentCount - 1
      }

}

extension SearchResultViewController:RecipeViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
    

        guard let indexPaths = newIndexPathsToReload else {
           searchResultView.customActivityIndictator.stopAnimating()
            searchResultView.resultCollectionView.reloadData()
            return}
        
        
        searchResultView.customActivityIndictator.stopAnimating()
        searchResultView.resultCollectionView.insertItems(at: indexPaths)
        
       
        
        
        
    }
    
    func onFetchFailed(with reason: String) {
    searchResultView.customActivityIndictator.stopAnimating()
        self.showAlert(title: "Warning", message: reason)
    }
    
    
}
