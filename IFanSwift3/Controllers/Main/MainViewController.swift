
import UIKit
import SnapKit

enum ControllerStatus{
    case full
    case small
}

class MainViewController: UIViewController{
    
    
    fileprivate var vcStatus: ControllerStatus = .full
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        UIApplication.shared.setStatusBarHidden(true, with: .none)
        setUpRootViewControllers()
        
        
        self.view.addSubview(menuController.view)
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.mainHeaderView)
        self.view.addSubview(self.redLineView)
        self.view.addSubview(self.menuButton)
        self.view.addSubview(self.classifyButton)
        
        setupBtnConstraints()
    }
        
    
    fileprivate func setupBtnConstraints(){
        self.menuButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(35)
            make.width.height.equalTo(45)
        }
        
        self.classifyButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(35)
            make.width.height.equalTo(45)
        }
    }
    
    fileprivate lazy var mainHeaderView: MainHeaderView = {
        let headerView = MainHeaderView(frame: CGRect(x: 0, y: 0, width: self.scrollView.contentSize.width, height: 20))
        return headerView
    }()
    
    fileprivate lazy var redLineView:UIView = {
        let line = UIView()
        line.frame = CGRect(x: self.view.center.x - 20, y: 0, width: 40, height: 1)
        line.backgroundColor = UIConstant.UI_COLOR_RedTheme
        return line
        
    }()
    
    fileprivate lazy var classifyButton: UIButton = {
        let button = UIButton()
        let img = UIImage(imageLiteralResourceName: "ic_circle")
        button.setImage(img, for: UIControlState())
        button.addTarget(self, action: #selector(MainViewController.classifyBtnClicked), for: .touchUpInside)
        return button
    }()
    
    
    /*
     菜单按钮
    */
    fileprivate lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName:"ic_hamburg"), for: UIControlState())
        button.addTarget(self, action: #selector(MainViewController.menuBtnClicked(_:)), for: .touchUpInside)
        return button
    }()
   
    
    override var prefersStatusBarHidden : Bool {
        return statusBarHidden
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return statusBarStyle
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return .slide
    }
    
    fileprivate var statusBarStyle: UIStatusBarStyle = .lightContent
    
    fileprivate var statusBarHidden = true
    
    func setUpRootViewControllers(){
        
        
        newsFlashController.scrollViewReusableDatSource = self
        homeController.scrollViewReusableDatSource = self
        playingzhiController.scrollViewReusableDatSource = self
//        appsoController.scrollViewReusableDataSource = self
//        mindStoreController.scrollViewReusableDataSource = self
        
        newsFlashController.scrollViewControllerReusableDelegate = self
        homeController.scrollViewControllerReusableDelegate = self
        playingzhiController.scrollViewControllerReusableDelegate = self
//        appsoController.scrollViewReusableDelegate = self
//        mindStoreController.scrollViewReusableDelegate = self

        
        menuController.view.frame = self.view.bounds
        
        self.addChildViewController(menuController)
        
        self.addChildViewController(newsFlashController)
        self.addChildViewController(homeController)
        self.addChildViewController(playingzhiController)
        self.addChildViewController(appsoController)
        self.addChildViewController(mindStoreController)
        viewArray.append(newsFlashController.view)
        viewArray.append(homeController.view)
        viewArray.append(playingzhiController.view)
        viewArray.append(appsoController.view)
        viewArray.append(mindStoreController.view)
        
        for i in 0..<viewArray.count{
            let view = viewArray[i]
            view.frame = CGRect(x: self.view.width*CGFloat(i), y: 0, width: self.scrollView.width, height: self.scrollView.height)
            self.scrollView.addSubview(view)
        }
        self.scrollView.contentSize = CGSize(width: self.scrollView.width*CGFloat(viewArray.count), height: self.scrollView.height)
        self.scrollView.setContentOffset(CGPoint(x: scrollView.width, y: 0), animated: false)
    }
    
    let menuController = MenuViewController()
    
    let newsFlashController = NewsFlashViewController()
    let homeController = HomeViewController()
    let playingzhiController = PlayingzhiViewController()
    let appsoController = AppsoViewController()
    let mindStoreController = MindStoreViewController()
    
    fileprivate var viewArray = [UIView]()
    
    fileprivate let scale: CGFloat = 0.4

    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.view.width, height: self.view.height - UIConstant.UI_MARGIN_20))
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    fileprivate var coverBtnArray: [UIButton] = []
    
    
    fileprivate func createCoverBtn() -> UIButton{
        let button = UIButton()
        button.backgroundColor = UIColor.black.withAlphaComponent(0.02)
        button.addTarget(self, action: #selector(MainViewController.menuBtnClicked(_:)), for: .touchUpInside)
        return button
    }

    
}



extension MainViewController{
    
    fileprivate func removeCategoryView(_ categoryView: CategoryView){
        UIView.animate(withDuration: 0.5, animations: { 
            categoryView.alpha = 0
            self.mainHeaderView.alpha = 1
            }, completion: { (com) in
                categoryView.removeFromSuperview()
        }) 
    }
    
    @objc fileprivate func classifyBtnClicked(){
        
        let categoryView = CategoryView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height))
        categoryView.alpha = 0
        self.view.addSubview(categoryView)
        UIView.animate(withDuration: 0.5, animations: { 
            categoryView.alpha = 1
            self.mainHeaderView.alpha = 0
        }) 
        
        categoryView.coverBtnClick { [unowned self] in
            self.removeCategoryView(categoryView)
        }
        
        categoryView.itemBtnDidClick {[unowned self] (collectionView, indexPath) in
            self.removeCategoryView(categoryView)
            if (indexPath as NSIndexPath).row == 0{
                return
            }
            self.navigationController?.pushViewController(CategoryController(categoryModel: categoryModelArray[(indexPath as NSIndexPath).row]), animated: true)
        }
    }
    
    @objc fileprivate func menuBtnClicked(_ view: UIView){
        
        setupCornerRadius()
        
        setupViewAnimation(view.tag)
        
    }
    
    fileprivate func setupCornerRadius(){
       
        UIView.animate(withDuration: 0.5, animations: {[unowned self] in
            
            self.viewArray.forEach{
                let maskPath = UIBezierPath(roundedRect: $0.bounds, cornerRadius: self.vcStatus == .small ? 0:20)
                let maskLayer = CAShapeLayer()
                maskLayer.frame = $0.bounds
                maskLayer.path = maskPath.cgPath
                $0.layer.mask = maskLayer
                
            }
        })
    }
    
    /**
     执行放大收缩动画前需要隐藏和显示一些控件
     */
    fileprivate func setupViewHidden(_ tag: Int = 0) {
        
        // 设置状态栏
        statusBarHidden = vcStatus == .small ?true:false
        setNeedsStatusBarAppearanceUpdate()
        // 设置菜单分类按钮,下拉刷新
        self.mainHeaderView.isHidden = vcStatus == .small ?false:true
        self.redLineView.isHidden = vcStatus == .small ?false:true
        if tag == 1 {
            self.classifyButton.alpha = 1
            self.classifyButton.isHidden = vcStatus == .small ?false:true
        } else {
            self.classifyButton.isHidden = true
        }
        self.menuButton.isHidden = vcStatus == .small ?false:true
    }

    fileprivate func setupViewAnimation(_ tag: Int = 0){
        let scaleWidth = vcStatus == .small ? scrollView.width:scrollView.width * scale
        let transY = vcStatus == .small ?self.view.center.y+UIConstant.UI_MARGIN_10:scrollView.center.y+scrollView.height*(1-scale)*0.5
        let scrollViewTransCenter = CGPoint(x: self.scrollView.center.x, y: transY)
        // contentsize
        let contentSize = vcStatus == .small ?CGSize(width: self.view.width*CGFloat(viewArray.count), height: 0):CGSize(width: (scaleWidth+UIConstant.UI_MARGIN_5)*CGFloat(self.viewArray.count), height: 0)
        // transform
        let scrollviewtransform = vcStatus == .small ? CGAffineTransform.identity:CGAffineTransform(scaleX: 1, y: self.scale)
        let scrollsubviewTransform = vcStatus == .small ?CGAffineTransform.identity:CGAffineTransform(scaleX: self.scale, y: 1)
        // 获取点击后scrollview的contentoffset位置
        let index = vcStatus == .small ?tag:Int(scrollView.contentOffset.x/self.view.width)
        var contentOffx = vcStatus == .small ?CGFloat(index)*self.view.width:0.5*UIConstant.UI_MARGIN_5+CGFloat(index)*(scaleWidth+UIConstant.UI_MARGIN_5)
        contentOffx = contentOffx > contentSize.width-self.view.width ?contentSize.width-self.view.width:contentOffx
        // 设置头部空间位移差
        if vcStatus == .small {
            let headerViewScale = self.view.width/(self.view.width*0.5-mainHeaderView.labelArray.last!.width*0.5)
            mainHeaderView.x = -contentOffx/headerViewScale
            
            
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { 
            [unowned self] in
            self.scrollView.center = scrollViewTransCenter
            self.scrollView.transform = scrollviewtransform
            self.scrollView.contentSize = contentSize
            
            self.scrollView.setContentOffset(CGPoint(x: contentOffx,y: 0), animated: false)
            self.setupViewHidden(tag)
            // 设置srollview子控件的动画
            for i in 0..<self.viewArray.count {
                let view = self.viewArray[i]
                
                view.transform = scrollsubviewTransform
                let centerX = self.vcStatus == .small ? scaleWidth*(CGFloat(i)+0.5):(scaleWidth+UIConstant.UI_MARGIN_5)*(CGFloat(i)+0.5)
                view.center = CGPoint(x: centerX, y: view.center.y)
            }

            }) { (result) in
                if result{
                    
                    if self.vcStatus == .small{
                        self.coverBtnArray.forEach{
                            $0.removeFromSuperview()
                        }
                    }else{
                        for i in 0..<self.viewArray.count{
                            let view = self.viewArray[i]
                            let coverBtn = self.createCoverBtn()
                            coverBtn.frame = view.bounds
                            coverBtn.tag = i
                            self.coverBtnArray.append(coverBtn)
                            view.addSubview(coverBtn)
                        }
                    }
                    
                    // 设置scrollview
                    self.scrollView.isPagingEnabled = self.vcStatus == .small ?true:false
                    
                    self.vcStatus = self.vcStatus == .full ?.small:.full
                    
                }
        }
        
    }
    
    
}



extension MainViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if vcStatus == .full{
            let contentOffsetX = scrollView.contentOffset.x
            let alpha = 1 - fabs((contentOffsetX-UIConstant.SCREEN_WIDTH) / UIConstant.SCREEN_WIDTH)
            classifyButton.isHidden = alpha <= 0 ?true: false
            classifyButton.alpha = alpha
            // 设置头部空间位移差
            let scale = self.view.width/(self.view.width*0.5-mainHeaderView.labelArray.last!.width*0.5)
            mainHeaderView.x = -scrollView.contentOffset.x/scale
        }
    }
    
}

extension MainViewController: ScrollViewControllerReusableDataSource{
    
    func titleHead() -> MainHeaderView {
        return self.mainHeaderView
    }
    
    func menuBtn() -> UIButton {
        return self.menuButton
    }
    
    func classifyBtn() -> UIButton {
        return self.classifyButton
    }
    
    func readLine() -> UIView {
        return self.redLineView
    }
    
}


extension MainViewController: ScrollViewControllerReusableDelegate{
    
    func scrollViewControllerDirectionDidChange(_ direction: ScrollviewDirection) {
        menuBtnAnimation(direction)
    }
    
    fileprivate func menuBtnAnimation(_ dir: ScrollviewDirection){
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.fromValue = (dir == ScrollviewDirection.down ?  classifyButton.y : -classifyButton.height )
        positionAnimation.toValue = (dir == ScrollviewDirection.down ?(-classifyButton.height):classifyButton.y+20)
        
        let alphaAnim = CABasicAnimation(keyPath: "alpha")
        alphaAnim.fromValue = (dir == ScrollviewDirection.down ?1:0)
        alphaAnim.toValue = (dir == ScrollviewDirection.down ?0:1)
        
        let group = CAAnimationGroup()
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        group.animations = [positionAnimation, alphaAnim]
        group.duration = 0.2
        
        classifyButton.layer.add(group, forKey: "circleButtonDownAnimation")
        menuButton.layer.add(group, forKey: "hamburgButtonAnimation")
    }
    
}






