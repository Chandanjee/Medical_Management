//
//  AnalyticReportVC.swift
//  Decoy
//
//  Created by MAC on 12/12/21.
//

import UIKit

class AnalyticReportVC: UIViewController {
    var tabController: VC_TYPE = .Profile
    @IBOutlet weak var collectionViews: UICollectionView!
    let collectionData = OfficialCollection()
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func initCollectionView() {
       let cells = [AnalticReportCell.className]
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
extension AnalyticReportVC:UICollectionViewDelegateFlowLayout{
    
    
//                func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//                    let noOfCellsInRow = 2   //number of column you want
//                    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//                    let totalSpace = flowLayout.sectionInset.left
//                        + flowLayout.sectionInset.right
//                        + (30.0 * CGFloat(noOfCellsInRow - 1))
//
//                    let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
//                    return CGSize(width: size, height: 150)
//                }
        
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

extension AnalyticReportVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.AnalyticalReport.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalticReportCell", for: indexPath) as? AnalticReportCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.configure()
        cell.loadCollectionData(entry: collectionData.AnalyticalReport[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let name = collectionData.AnalyticalReport[indexPath.item]
        
        print(name.title)
//        if (name.title == "Camp Plan") {
//
//        }else if (name.title == "Add Family Member"){
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let v1 = storyboard.instantiateViewController(withIdentifier:"AddFamilyViewController") as? AddFamilyViewController
////                v1?.targetOption = name.title
//                self.navigationController?.pushViewController(v1!, animated: true)
//        }else{
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let v1 = storyboard.instantiateViewController(withIdentifier:"UserInfoViewController") as? UserInfoViewController
//            v1?.targetOption = name.title
//            self.navigationController?.pushViewController(v1!, animated: true)
//
//        }
    }
    
}
