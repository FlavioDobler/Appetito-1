//
//  ReservationView.swift
//  Appetito
//
//  Created by Flavio Dobler on 2022-09-01.
//

import UIKit

protocol ReservationViewProtocol: AnyObject {
    func tappedDateTextField()
    func tappedConfirm()
}
extension ReservationViewProtocol{
    func tappedDateTextField(){}
}

class ReservationView: UIView {
    
    weak var delegate: ReservationViewProtocol?
    
    private lazy var restaurantImageView: UIImageView = {
        let restaurantImageView = UIImageView()
        restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
        restaurantImageView.contentMode = .scaleAspectFit
        restaurantImageView.image = UIImage(named: "fogoChaoBanner")
        restaurantImageView.layer.cornerRadius = 8
        restaurantImageView.backgroundColor = .black
        
        return restaurantImageView
    }()
    
    private lazy var informationLabel: UILabel = {
        let informationLabel = UILabel(frame: .zero)
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.numberOfLines = 0
        informationLabel.font = UIFont(name:"KohinoorDevanagari-Light", size:12)
        informationLabel.text = "Atenção: Preencha todas as informações para confirmar sua reserva"
        informationLabel.textColor = .white
        informationLabel.textAlignment = .center
        
        return informationLabel
    }()
    
    private lazy var dateTextField: UITextField = {
        let dateTextField = UITextField(frame: .zero)
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.backgroundColor = .white
        dateTextField.layer.cornerRadius = 8
        dateTextField.placeholder = "  Escolha uma data"
        dateTextField.textColor = UIColor.black
        dateTextField.addTarget(self, action: #selector(tappedDate), for: .touchUpInside)
        
        return dateTextField
    }()
    
    private lazy var amountPeopleLabel: UILabel = {
        let amountPeopleLabel = UILabel(frame: .zero)
        amountPeopleLabel.translatesAutoresizingMaskIntoConstraints = false
        amountPeopleLabel.numberOfLines = 0
        amountPeopleLabel.font = UIFont(name:"KohinoorDevanagari-Light", size:16)
        amountPeopleLabel.text = "Quantidade de pessoas"
        amountPeopleLabel.textColor = .white
        
        return amountPeopleLabel
    }()
    
    private lazy var addPeople: UIStepper = {
        let addPeople = UIStepper()
        addPeople.translatesAutoresizingMaskIntoConstraints = false
        addPeople.layer.cornerRadius = 8
        
        return addPeople
    }()
    
    private lazy var occasionLabel: UILabel = {
        let occasionLabel = UILabel(frame: .zero)
        occasionLabel.translatesAutoresizingMaskIntoConstraints = false
        occasionLabel.numberOfLines = 0
        occasionLabel.font = UIFont(name:"KohinoorDevanagari-Light", size:16)
        occasionLabel.text = "Digite a ocasião"
        occasionLabel.textColor = .white
        
        return occasionLabel
    }()
    
    private lazy var occasionTextField: UITextField = {
        let occasionTextField = UITextField(frame: .zero)
        occasionTextField.translatesAutoresizingMaskIntoConstraints = false
        occasionTextField.layer.cornerRadius = 8
        occasionTextField.placeholder = "  Opcional"
        occasionTextField.backgroundColor = .white
        occasionTextField.textColor = UIColor.black
        
       return occasionTextField
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: "mainYellow")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("CONFIRMAR", for: .normal)
        button.addTarget(self, action: #selector(tappedConfirm), for: .touchUpInside)
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
       setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedConfirm(){
        self.delegate?.tappedConfirm()
    }
    
    
    @objc func tappedDate(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = NSLocale.init(localeIdentifier: "pt-br") as Locale
        datePicker.preferredDatePickerStyle = .wheels
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(self.exibeData), for: .valueChanged)
    }
    
    @objc func exibeData(sender:UIDatePicker) {
        let formate = DateFormatter()
        formate.dateFormat = "dd/MM/yyyy"
        let date = UIDatePicker()
        self.dateTextField.text = formate.string(from: date.date)
    }
    
    @objc func addDoneButton() -> UIToolbar{
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "ok", style: .done, target: self, action:#selector(addDoneButton))
        let itens = [flexSpace, done]
        doneToolbar.items = itens
        doneToolbar.sizeToFit()
        
        return doneToolbar
    }

    @objc func doneButtonAction() {
        self.endEditing(true)
    }
}

extension ReservationView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(restaurantImageView)
        addSubview(informationLabel)
        addSubview(dateTextField)
        addSubview(amountPeopleLabel)
        addSubview(addPeople)
        addSubview(occasionLabel)
        addSubview(occasionTextField)
        addSubview(confirmButton)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            restaurantImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            restaurantImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            restaurantImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            restaurantImageView.heightAnchor.constraint(equalToConstant: 200),
            restaurantImageView.widthAnchor.constraint(equalToConstant: 200),
            
            informationLabel.topAnchor.constraint(equalTo: restaurantImageView.bottomAnchor, constant: 16),
            informationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            informationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            informationLabel.heightAnchor.constraint(equalToConstant: 40),
            
            dateTextField.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 16),
            dateTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            dateTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            dateTextField.heightAnchor.constraint(equalToConstant: 40),
            
            amountPeopleLabel.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20),
            amountPeopleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            amountPeopleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            amountPeopleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            addPeople.topAnchor.constraint(equalTo: amountPeopleLabel.bottomAnchor, constant: 20),
            addPeople.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            addPeople.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            addPeople.heightAnchor.constraint(equalToConstant: 40),
            
            occasionLabel.topAnchor.constraint(equalTo: addPeople.bottomAnchor, constant: 20),
            occasionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            occasionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            occasionLabel.heightAnchor.constraint(equalToConstant: 35),
            
            occasionTextField.topAnchor.constraint(equalTo: occasionLabel.bottomAnchor, constant: 20),
            occasionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            occasionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            occasionTextField.heightAnchor.constraint(equalToConstant: 40),
            
            confirmButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            confirmButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 48)
            
        ])
    }
    func setupAdditionalConfiguration() {
        self.dateTextField.inputAccessoryView = self.addDoneButton()
    }

}
