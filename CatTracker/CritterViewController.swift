//
//  ViewController.swift
//  CatTracker
//
//  Created by Gloria Tse on 21/10/2017.
//  Copyright © 2017年 Gloria Tse. All rights reserved.
//

import UIKit
import os.log

//class ViewController: UIViewController {
//class ViewController: UIViewController, UITextFieldDelegate {
class CritterViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var critter: Critter?

    
    
    
    // MARK: properties
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var detailsTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
                os_log("Save button was not pressed, cancelling", log: OSLog.default, type: .debug)
                return }
        let name = nameTextField.text
        let photo = photoImageView.image
        let details = detailsTextField.text
        critter = Critter(name: name!, photo: photo, details:details!)
    }
    
    
    // MARK :action
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String: Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but provided \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = nameTextField.text
    }
    
    //MARK: Private methods
    private func updateSaveButtonState() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}

