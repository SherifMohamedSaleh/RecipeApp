//
//  RecipeDetailsViewController.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 30/11/2021.
//

import UIKit
import SDWebImage


class RecipeDetailsViewController: BaseViewController{
    var hits : Hit?
    
    @IBOutlet weak var RecipeImg: UIImageView!
    @IBOutlet weak var Recipe_Ingredient: UILabel!
    @IBOutlet weak var Recipe_Button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func RecipeButtonAction(_ sender: Any) {
        guard let url = URL(string: hits?.recipe?.url ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    
    func setupView(){
        // title
        self.title = hits?.recipe?.label
        // image
        let ImageUrl = URL(string: hits?.recipe?.image ?? "")
        RecipeImg.sd_setImage(with: ImageUrl, placeholderImage: UIImage(named: "placeholder"), options: .refreshCached, context: nil)
        // ingreduient
        Recipe_Ingredient.text =  buildIngredientString()
        // url
        if hits?.recipe?.url != "" || hits?.recipe?.url != nil {
            Recipe_Button.isHidden = false
        } else {
            Recipe_Button.isHidden = true
        }
    }
    
    func buildIngredientString() -> String  {
        var ingredientString = ""
        for hit in (hits?.recipe?.ingredientLines)! {
            ingredientString += "* " + hit + "\n"
        }
        return ingredientString
    }
}
