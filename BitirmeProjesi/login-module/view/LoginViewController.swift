//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 20.10.2022.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {

    //MARK: Views
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var animationNext: LottieAnimationView!
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        setupAnimation2()
    }
    
    //MARK: Private Func
    
    private func setupAnimation() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
    private func setupAnimation2() {
        animationNext.contentMode = .scaleAspectFit
        animationNext.loopMode = .loop
        animationNext.play()
    }
}
