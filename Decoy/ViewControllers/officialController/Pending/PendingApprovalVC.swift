//
//  PendingApprovalVC.swift
//  Decoy
//
//  Created by MAC on 12/12/21.
//

import UIKit


class PendingApprovalVC: UIViewController {
    var tabController: VC_TYPE = .Setting
    @IBOutlet weak var collectionViews: UICollectionView!
    let collectionData = OfficialCollection()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func initCollectionView() {
       let cells = [PendingApprovalCell.className]
       collectionViews.registerCollection(cells)
        collectionViews.delegate = self
        collectionViews.dataSource = self
   }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PendingApprovalVC:UICollectionViewDelegateFlowLayout{
    

        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//                   return CGSize(width: collectionView.frame.size.width / 2 - 10 , height:150)
            let leftAndRightPaddings: CGFloat = 60
                  let numberOfItemsPerRow: CGFloat = 2.0

                  let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
                  return CGSize(width: width, height: 150)
           }
           
           
               func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
                   return UIEdgeInsets(top: 30, left: 20, bottom: 30, right:20)
           }
           
    }

extension PendingApprovalVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.PendingApproval.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PendingApprovalCell", for: indexPath) as? PendingApprovalCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.configure()
        cell.loadCollectionData(entry: collectionData.PendingApproval[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let name = collectionData.PendingApproval[indexPath.item]
        
        print(name.title)
       
    }
    
}
