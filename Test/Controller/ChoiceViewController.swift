//
//  ChoiceViewController.swift
//  Test
//
//  Created by Гурген on 14.01.2021.
//

import UIKit

class ChoiceViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var choiceButton: UIButton!
    
    private var screens : Screen?
    private var message: String = ""
    
    override func viewDidLoad() {
        initCollectionView()
        fetchData()
    }
    
    func initCollectionView() {
        self.collectionView.register(UINib(nibName: "ChoiceCell", bundle: nil), forCellWithReuseIdentifier: "Choice")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func updateUI(model: Screen?) {
        self.collectionView.reloadData()
        self.infoLabel.text = model?.title
        self.choiceButton.setTitle(model?.actionTitle, for: .normal)
    }
    
    func fetchData() {
        Network.fetchData { (screen) in
                self.screens = screen
                DispatchQueue.main.async {
                    self.updateUI(model: self.screens)
                }
            }
    }
    
    @IBAction func choiceButton(_ sender: UIButton) {
            let alert = UIAlertController(title: "Услуга", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Принять", style: .default)
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
    }

extension ChoiceViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ChoiceCellCollectionViewCell
        if !cell.checkStatus.isHidden {
            cell.checkStatus.isHidden = true
            self.choiceButton.setTitle(screens?.actionTitle, for: .normal)
            message = "Вы продолжили без изменений"
        } else {
            cell.checkStatus.isHidden = false
            self.choiceButton.setTitle(screens?.selectedActionTitle, for: .normal)
            message = (screens?.cellItem[indexPath.row].title)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ChoiceCellCollectionViewCell
        cell.checkStatus.isHidden = true
    }
}

extension ChoiceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screens?.cellItem.count ?? .zero
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Choice", for: indexPath) as! ChoiceCellCollectionViewCell
        cell.configure(screen: screens!, indexPath: indexPath)
            return cell
        }
    
}
