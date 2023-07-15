//
//  ViewController.swift
//  UIKit-lab-5
//
//  Created by Iliya Rahozin on 15.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Present", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tapButton)
        
        tapButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tapButton.widthAnchor.constraint(equalToConstant: 100),
            tapButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonTapped() {
       let popover = PopoverViewController()
       popover.preferredContentSize = CGSize(width: 300, height: 280)
       popover.modalPresentationStyle = .popover
       if let pres = popover.presentationController {
          pres.delegate = self
      }
       if let pop = popover.popoverPresentationController {
           pop.sourceView = tapButton
           pop.permittedArrowDirections = .up
           pop.sourceRect = tapButton.bounds
       }
       
       present(popover, animated: true)
   }


}

extension ViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}


class PopoverViewController: UIViewController {
    
    private var segmentView: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["280pt", "150pt"])
        segment.selectedSegmentIndex = 0
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        return segment
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark.circle.fill")?.applyingSymbolConfiguration(.init(scale: .large))
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.backgroundColor = .clear
        button.tintColor = .systemGray3
        button.imageView?.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 280)
        view.backgroundColor = .white
        view.addSubviews(segmentView, closeButton)
        
        segmentView.addTarget(self, action: #selector(changeSegment), for: .valueChanged)
        closeButton.addTarget(self, action: #selector(closeControl), for: .touchUpInside)

        NSLayoutConstraint.activate([
            segmentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            
            closeButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func changeSegment() {
        if (segmentView.selectedSegmentIndex == 0) {
            preferredContentSize = CGSize(width: 300, height: 280)
            
        }
        
        if (segmentView.selectedSegmentIndex == 1) {
            preferredContentSize = CGSize(width: 300, height: 150)
        }
    }
    
    @objc func closeControl() {
        dismiss(animated: true)
    }
}


extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
