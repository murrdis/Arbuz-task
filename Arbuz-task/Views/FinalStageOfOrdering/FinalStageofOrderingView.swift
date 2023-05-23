//
//  FinalStageofOrderView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 21.05.2023.
//

import SwiftUI

struct FinalStageofOrderingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - View Properties
    @State var showAdressModel: Bool = false
    @State private var showPaymentModel = false
    @State private var showChangingModel = false
    @State private var showTipsModel = false
    @State private var showFollowPeriodModel = false
    @State private var isCommentsTapped = false
    @State private var isLackofAssortmentTapped = false
    @State private var isBonusesTapped = false
    @State private var showingPaymentAlert = false
    @State private var showingOrderAlert = false
    @State private var showingPhoneVerificationAlert = false
    
    @State var typedTip = ""
    @State var typedFollowPeriod = ""
    
    @State var isFollowPeriodTapped = false
    @State var isPromocodeValid = false
    
    @State private var selectedDay = "Пн"
    @State private var selectedFollowPeriod = "4 недели"
    @State private var selectedTime = "07:00-09:00"
    @State private var nameText = ""
    @State private var commentsText = ""
    @State private var lackofAssortment = ""
    @State private var paymentMethod = "Онлайн банковской картой"
    @State private var promocode = ""
    @State private var сhangingNeeded = "Заменить товар на другой"
    @State private var selectedTip = "200 ₸"
    @State private var selectedOwnTip = 0
    @State private var selectedOwnFollowPeriod = 0

    @ObservedObject var cartViewModel = CartViewModel.cartObj
    @ObservedObject var db = DataBase.db
    
    @State private var address = CartViewModel.cartObj.currentAddress
    @State private var total = CartViewModel.cartObj.totalSum
    
    @State private var selectedPaymentWay = "Kaspi"
    // MARK: - static properties
    private enum Constants {
        static let lightGrayColor = Color(red: 242/255, green: 1, blue: 242/255)
        
        static let rightPromocode = "Возьмите меня"
        static let daysOfWeek = ["Пн","Вт","Ср","Чт","Пт","Сб","Вс"]
        static let times = ["07:00-09:00","08:00-10:00","09:00-11:00","10:00-12:00","11:00-13:00","12:00-14:00","13:00-15:00","14:00-16:00","15:00-17:00","16:00-18:00","17:00-19:00","18:00-20:00","19:00-21:00","20:00-22:00","21:00-23:00","22:00-00:00"]
        static  let followPeriods = ["4 недели","6 недель","8 недель","10 недель","12 недель","14 недель","16 недель"]
        static let tips = ["0 ₸","200 ₸","500 ₸","700 ₸", "Другая сумма"]
    }

    
    // MARK: - body
    var body: some View {
        
            ScrollView {
                VStack() {
                    DeliveryAddressView(showAdressModel: $showAdressModel, address: $address)
                    
                    Group {
                        CustomHeaderView(text: "День доставки")
                        
                        CustomScrollView(array: Constants.daysOfWeek, selected: $selectedDay, foregroundColorForChosen: .green, backgroundColorForChosen: Constants.lightGrayColor)
                        
                        CustomHeaderView(text: "Время доставки")
                        
                        CustomScrollView(array: Constants.times, selected: $selectedTime, foregroundColorForChosen: .green, backgroundColorForChosen: Constants.lightGrayColor)
                        
                        CustomHeaderView(text: "Срок подписки")
                        
                        CustomScrollView(array: Constants.followPeriods, selected: $selectedFollowPeriod, foregroundColorForChosen: .green, backgroundColorForChosen: Constants.lightGrayColor)
                    }
                    Group {
                        CustomHeaderView(text: "Контактная информация")
                        
                        //Name
                        TextInputField("Имя получателя", text: $nameText)
                        .isMandatory()
                        .clearButtonHidden()
                        
                        
                        //Comments
                        CustomTextFieldView(textField: $commentsText, isTapped: $isCommentsTapped, label: "Комментарий")
                        
                        //Lack of assortment
                        CustomTextFieldView(textField: $lackofAssortment, isTapped: $isLackofAssortmentTapped, label: "Чего не хватило в ассортименте")
                        
                        CustomHeaderView(text: "Оплата")
                        
                        Button() {
                            showPaymentModel = true
                        } label: {
                            HStack {
                                Image(systemName: "creditcard").foregroundColor(.black)
                                Text(paymentMethod)
                                    .foregroundColor(.black)
                                    .font(.custom("Arial", size: 15))
                                Spacer()
                                Text(">")
                                    .foregroundColor(.gray)
                            }
                        }.padding(.vertical, 5)
                        
                        Divider()
                        
                        Toggle(isOn: $isBonusesTapped) {
                            HStack {
                                Image(systemName: "face.smiling").foregroundColor(.black)
                                VStack(alignment: .leading) {
                                    Text(" Потратить Бонусы")
                                        .font(.custom("Arial", size: 15))
                                    Text(" \(cartViewModel.bonuses) ₸ бонусов накоплено")
                                        .font(.custom("Arial", size: 10))
                                        .foregroundColor(.gray)
                                        .frame(alignment: .leading)
                                        .padding(.horizontal, 2)
                                }
                            }
                        }.padding(.vertical, 5)
                        
                        TextInputField("Промокод", text: $promocode, isValid: $isPromocodeValid).clearButtonHidden().padding(.vertical, 7)

                    }
                    Group {
                        Button() {
                            showChangingModel = true
                        } label: {
                            HStack {
                                Image(systemName: "arrow.2.squarepath").foregroundColor(.black)
                                VStack(alignment: .leading) {
                                    Text("Если товара не будет в наличии")
                                        .foregroundColor(.black)
                                        .font(.custom("Arial", size: 15))
                                    Text(сhangingNeeded)
                                        .font(.custom("Arial", size: 10))
                                        .foregroundColor(.gray)
                                        .frame(alignment: .leading)
                                        .padding(.horizontal, 1)
                                }
                                Spacer()
                                Text(">")
                                    .foregroundColor(.gray)
                            }
                        }.padding(.vertical, 5)

                        Divider()

                        CustomHeaderView(text: "Чаевые курьеру")

                        CustomScrollView(array: Constants.tips, selected: $selectedTip, foregroundColorForChosen: .black, backgroundColorForChosen: Color(red: 1, green: 236/255, blue: 195/255))

                        HStack {
                            Image(systemName: "info.circle").foregroundColor(.black)
                            Text("Чек и накладную можно посмотреть в истории заказов после доставки")
                                .font(.custom("Arial", size: 12))
                                .foregroundColor(.gray)
                        }.padding(.vertical, 15)
                    }
                    ZStack(alignment: .bottom) {
                        GeometryReader { geometry in
                            Image("bgSwitch2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                        .edgesIgnoringSafeArea(.all)
                        .padding(.horizontal, -20)
                        Group {
                            VStack(spacing: 15) {
                                HStack {
                                    Text("Продукты")
                                        .font(.custom("Arial", size: 13))
                                    Spacer()
                                    Text("\(cartViewModel.totalSum) ₸")
                                        .font(.custom("Arial", size: 13))
                                }
                                HStack {
                                    Text("Стоимость доставки")
                                        .font(.custom("Arial", size: 13))
                                    Spacer()
                                    Text("Бесплатно")
                                        .font(.custom("Arial", size: 13))
                                }
                                HStack {
                                    Text("Чаевые")
                                        .font(.custom("Arial", size: 13))
                                    Spacer()
                                    if selectedTip == "Другая сумма" {
                                        Text("\(selectedOwnTip) ₸")
                                            .font(.custom("Arial", size: 13))
                                    } else {
                                        Text("\(selectedTip)")
                                            .font(.custom("Arial", size: 13))
                                    }

                                }

                                if isBonusesTapped {
                                    HStack {
                                        Text("Cписание бонусов")
                                            .font(.custom("Arial", size: 13))
                                            .foregroundColor(.green)
                                        Spacer()
                                        Text("-\(cartViewModel.bonuses) ₸")
                                            .font(.custom("Arial", size: 13))
                                            .foregroundColor(.green)
                                    }
                                }
                                if promocode == Constants.rightPromocode {
                                    HStack {
                                        Text("Промо: Возьмите меня")
                                            .font(.custom("Arial", size: 13))
                                            .foregroundColor(.green)
                                        Spacer()
                                        Text("-0 ₸")
                                            .font(.custom("Arial", size: 13))
                                            .foregroundColor(.green)
                                    }
                                }

                                Divider()
                                HStack {
                                    Text("Итого")
                                        .font(.custom("Arial", size: 15))
                                        .fontWeight(.semibold)
                                    Spacer()
                                    if isBonusesTapped {
                                        if selectedTip == "Другая сумма" {
                                            Text("\(cartViewModel.totalSum + selectedOwnTip - cartViewModel.bonuses) ₸")
                                                .font(.custom("Arial", size: 17))
                                                .fontWeight(.semibold)
                                        } else {
                                            Text("\(cartViewModel.totalSum + (Int(selectedTip.dropLast(2)) ?? 0) - cartViewModel.bonuses) ₸")
                                                .font(.custom("Arial", size: 17))
                                                .fontWeight(.semibold)
                                        }
                                    } else {
                                        if selectedTip == "Другая сумма" {
                                            Text("\(cartViewModel.totalSum + selectedOwnTip) ₸")
                                                .font(.custom("Arial", size: 17))
                                                .fontWeight(.semibold)
                                        } else {
                                            Text("\(cartViewModel.totalSum + (Int(selectedTip.dropLast(2)) ?? 0)) ₸")
                                                .font(.custom("Arial", size: 17))
                                                .fontWeight(.semibold)
                                        }
                                    }
                                }
                                Button() {
                                    if !cartViewModel.phoneVerificationStatus {
                                        if isBonusesTapped {
                                            cartViewModel.bonuses = 0
                                        } else {
                                            cartViewModel.bonuses += (cartViewModel.totalSum * 5/100)
                                        }
                                        showingPhoneVerificationAlert.toggle()
                                    } else if nameText != "" {
                                        if isBonusesTapped {
                                            cartViewModel.bonuses = 0
                                        } else {
                                            cartViewModel.bonuses += (cartViewModel.totalSum * 5/100)
                                        }
                                        showingPaymentAlert.toggle()
                                    } else {
                                        showingOrderAlert.toggle()
                                    }
                                } label: {
                                    Spacer()
                                    Text("Подтвердить заказ")
                                        .foregroundColor(.white)
                                        .font(.custom("Arial", size: 15))
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 10)
                                    Spacer()
                                }
                                .background(.green)
                                .cornerRadius(15)
                                .buttonStyle(.bordered)

                                HStack {
                                    Spacer()
                                    Text("+ \(cartViewModel.totalSum * 5/100) ₸ бонусов")
                                        .foregroundColor(.green)
                                        .font(.custom("Arial", size: 15))
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                            }
                        }
                    }.padding(.top, 50)


                }
                .padding(.horizontal, 23)
                .sheet(isPresented: $showAdressModel) {
                    AddressModelView(selectedDay: $selectedDay, selectedFollowPeriod: $selectedFollowPeriod, selectedTime: $selectedTime)
                        .presentationDetents([.height(220)])
                }
                .sheet(isPresented: $showPaymentModel) {
                    showingModel(title: "Методы оплаты", choice1: "Онлайн банковской картой", choice2: "Банковской картой курьеру", isShowing: $showPaymentModel, method: $paymentMethod)
                        .presentationDetents([.height(300)])
                }
                .sheet(isPresented: $showChangingModel) {
                    showingModel(title: "Если товара не будет в наличии", choice1: "Заменить товар на другой", choice2: "Не делать замену товара", isShowing: $showChangingModel, method: $сhangingNeeded)
                        .presentationDetents([.height(320)])
                }
                .sheet(isPresented: $showTipsModel) {
                    TipsModelView(isShowing: $showTipsModel, tip: $selectedOwnTip, textfield: $typedTip)
                        .presentationDetents([.height(300)])
                }
                
                .sheet(isPresented: $showFollowPeriodModel) {
                    showingFollowPeriodModel(isShowing: $showFollowPeriodModel, period: $selectedOwnFollowPeriod, textfield: $typedFollowPeriod, isTextFieldTapped: $isFollowPeriodTapped)
                        .presentationDetents([.height(300)])
                }
                
                
            }
            .alert("Ошибка заказа", isPresented: $showingOrderAlert) {
            } message: {
                Text("Введите все необходимые данные!")
            }
        
            .alert("Ошибка заказа", isPresented: $showingPhoneVerificationAlert) {
            } message: {
                Text("Вы не авторизованы!")
            }
            .alert("Подписка оформлена!", isPresented: $showingPaymentAlert) {
                Button{
                    presentationMode.wrappedValue.dismiss()
                    for (product, quantity) in cartViewModel.selectedProducts {
                        if quantity >= db.goods[product] ?? 0 {
                            db.goods.removeValue(forKey: product)
                        }
                    }
                    cartViewModel.selectedProducts = [:]
                } label: {
                    Text("OK")
                }
            } message: {
                Text("\(selectedDay) \(selectedTime)")
                Text("Курьер свяжется в с вам перед доставкой")
            }
            .onTapGesture {
                hideKeyboard()
            }
        .navigationBarTitle("Оформление заказа", displayMode: .inline)
        
    }
    
    
    @ViewBuilder func CustomScrollView(array: [String], selected: Binding<String>, foregroundColorForChosen: Color, backgroundColorForChosen: Color) -> some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<array.count) { index in
                    Button() {
                        if array[index] == "Другая сумма" {
                            showTipsModel = true
                        }
                        selected.wrappedValue = array[index]
                    } label: {
                        Text(array[index])
                            .font(.custom("Arial", size: 15))
                            .foregroundColor(array[index] == selected.wrappedValue ? foregroundColorForChosen : .black)
                            .padding(10)
                            .background(array[index] == selected.wrappedValue ? backgroundColorForChosen : Color.clear)
                    }
                    .padding(.horizontal, 3)
                    .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                    .cornerRadius(12)
                }
            }
        }
    }
    
    
    
    @ViewBuilder func showingFollowPeriodModel(isShowing: Binding<Bool>, period: Binding<Int>, textfield: Binding<String>, isTextFieldTapped: Binding<Bool>) -> some View {
        
        VStack(spacing: 15) {
            Text("Период доставки")
                .font(.custom("Arial", size: 22))
                .fontWeight(.semibold).foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 8)
            CustomTextFieldView(textField: textfield, isTapped: isTextFieldTapped, label: "Введите количество недель").keyboardType(.decimalPad)
            Button() {
                period.wrappedValue = Int(typedFollowPeriod) ?? 0
                isShowing.wrappedValue = false
            } label: {
                Spacer()
                Text("Подтвердить")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)
                Spacer()
            }
            .background(.green)
            .cornerRadius(15)
            .buttonStyle(.bordered)
            
            Button() {
                isShowing.wrappedValue = false
            } label: {
                Spacer()
                Text("Отмена")
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)
                Spacer()
            }
            .background(Color(red: 242/255, green: 1, blue: 242/255))
            .cornerRadius(15)
            .buttonStyle(.bordered)
        }
        .padding(.horizontal, 23)
    }
    
    

    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct FinalStageofOrderingView_Previews: PreviewProvider {
    static var previews: some View {
        FinalStageofOrderingView()
    }
}
