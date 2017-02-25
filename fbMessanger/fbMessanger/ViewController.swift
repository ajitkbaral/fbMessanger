//
//  ViewController.swift
//  fbMessanger
//
//  Created by Ajit Kumar Baral on 2/25/17.
//  Copyright © 2017 Ajit Kumar Baral. All rights reserved.
//

import UIKit

class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //Making the cell identifier safe
    private let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting the title for the navigation 
        navigationItem.title = "Recent"
        
        //Setting the background of the view
        collectionView?.backgroundColor = UIColor.white
        
        //Setting the bounce of the list become smooth
        collectionView?.alwaysBounceVertical = true
        
        
        //Register the cell with the identifier
        collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    //Setting the number of sections
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    //Reusing the cell for the section
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    
    
    //Sizing the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)//Take full with for the view and hight of 100 points
    }



}

//Creating a cell
class FriendCell: BaseCell{
    
    //Creating an ImageView for the profile image
    let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 34
            imageView.layer.masksToBounds = true
            return imageView
    }()
    
    
    //Create a divider line view
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        return view
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ajit Kumar Baral"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Friend's message and something else..."
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timelabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //Overriding the method of the BaseCell
    override func setupViews() {
        
        //Setting the background color of the friends cell
        
        //backgroundColor = UIColor.white
        
        //Adding to the sub view
        addSubview(profileImageView)
        addSubview(dividerLineView)
        
        
        setupContainerView()
        
        //Setting the profile image
        profileImageView.image = UIImage(named: "me.jpg")
        
        //Setting the has read image
        hasReadImageView.image = UIImage(named: "me.jpg")
        
        //Using the addConstraints to the image
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //Using the addConstraints to the divider line view
        dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        
        //Setting the constraints for the image
        
        //Horizontal
        addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        
        //Vertical
        addConstraintsWithFormat(format: "V:[v0(68)]", views: profileImageView)
        
        //Centering the image in the view
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        
        //Setting for the divider line view
        
        //Horizontal
        addConstraintsWithFormat(format: "H:|-82-[v0]|", views: dividerLineView)
        
        //Vertical
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: dividerLineView)
        
    }
    
    private func setupContainerView(){
        
        //Creating the container view
        let containerView = UIView()
        
        //containerView.backgroundColor = UIColor.blue
        addSubview(containerView)
        
        
        //Horizontal
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
        
        //Vertical
        addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
        
        //Centering the image in the view
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        //Adding the subviews to the container view
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timelabel)
        containerView.addSubview(hasReadImageView)
        
        //For name label and time label
        
        //Horizontal
        containerView.addConstraintsWithFormat(format: "H:|[v0][v1(80)]-12-|", views: nameLabel, timelabel)
        
        //Vertial for both name label and the message label
        containerView.addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        
        //For messageLabel
        
        //Horizontal
        containerView.addConstraintsWithFormat(format: "H:|[v0]-8-[v1(20)]-12-|", views: messageLabel, hasReadImageView)
        
        //For time label
        
        //Vertical
        containerView.addConstraintsWithFormat(format: "V:|[v0(24)]", views: timelabel)
        
        //For has read image view
        
        //Vertical
        containerView.addConstraintsWithFormat(format: "V:[v0(20)]|", views: hasReadImageView)

    }
    
}

//Using the extension for the UIView
extension UIView{
    
    //Adding the constraints for the views
    func addConstraintsWithFormat(format: String, views: UIView...){
        
        //Creating the view dictionary
        var viewsDictionary = [String:UIView]()
        
        //Looping to get the view and its index
        for(index, view) in views.enumerated(){
            
            //Setting the key to the something like v0 or v1 etc...
            let key = "v\(index)"
            
            //Adding the view to the dictionary with the specified key
            viewsDictionary[key] = view
            
            //To apply the add constraints
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    
    }
}


//Create a generic base cell for the other cells
class BaseCell: UICollectionViewCell{
    
    //Overriding the init method from the super class
    override init(frame: CGRect){
        super.init(frame: frame)
        
        //Setting the views
        setupViews()
        
    }
    
    //Displaying the error
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Setting up the Views for the BaseCell
    func setupViews(){
        
        //Setting the background color of the base cell
        backgroundColor = UIColor.blue
    }
    
}





