//
//  TextInputField.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 23.05.2023.
//

import SwiftUI
import Combine

public struct TextInputField: View {
  private var title: String
  @Binding var text: String
  @Environment(\.clearButtonHidden) var clearButtonHidden
  @Environment(\.isMandatory) var isMandatory
  @Environment(\.validationHandler) var validationHandler
  
  @Binding private var isValidBinding: Bool
  @State private var isValid: Bool = false {
    didSet {
      isValidBinding = isValid
    }
  }
  @State var validationMessage: String = ""
  
  public init(_ title: String, text: Binding<String>, isValid isValidBinding: Binding<Bool>? = nil) {
    self.title = title
    self._text = text
    self._isValidBinding = isValidBinding ?? .constant(true)
  }
  
  var clearButton: some View {
    HStack {
      if !clearButtonHidden {
        Spacer()
        Button(action: { text = "" }) {
          Image(systemName: "multiply.circle.fill")
            .foregroundColor(Color(UIColor.systemGray))
        }
      }
      else  {
        EmptyView()
      }
    }
  }
  
  var clearButtonPadding: CGFloat {
    !clearButtonHidden ? 25 : 0
  }
  
  fileprivate func validate(_ value: String) {
    
    if isMandatory {
      isValid = !value.isEmpty
      validationMessage = isValid ? "" : "Это обязательное поле!"
    }
      if title == "Промокод" {
          if value != "Возьмите меня" && value != ""{
              isValid = false
              self.validationMessage = "Промокод не действителен"
          }
          else if value == "Возьмите меня" {
              self.isValid = true
              self.validationMessage = "Промокод активирован)"
          }
      }
  }

  public var body: some View {
    ZStack(alignment: .leading) {

      if (isMandatory && !isValid) || (!isValid && text != "") {
        Text(validationMessage)
          .foregroundColor(.red)
          .offset(y: -25)
          .scaleEffect(0.8, anchor: .leading)
      }
        if isValid && !isMandatory{
          Text(validationMessage)
            .foregroundColor(.green)
            .offset(y: -25)
            .scaleEffect(0.8, anchor: .leading)
        } else if (text.isEmpty || isValid) {
        Text(title)
          .foregroundColor(text.isEmpty ? Color(.placeholderText) : .gray)
          .offset(y: text.isEmpty ? 0 : -25)
          .scaleEffect(text.isEmpty ? 1: 0.8, anchor: .leading)
      }
      TextField("", text: $text)
        .onAppear {
          validate(text)
        }
        .onChange(of: text) { value in
          validate(value)
        }
        .padding(.trailing, clearButtonPadding)
        .overlay(clearButton)
    }
    .accentColor(.cyan)
    .padding(10)
    .padding(.horizontal, 7)
    .padding(.top, 15)
    .overlay(
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
    )
    .animation(.default, value: text)
  }
}

// MARK: - Clear Button

extension View {
  public func clearButtonHidden(_ hidesClearButton: Bool = true) -> some View {
    environment(\.clearButtonHidden, hidesClearButton)
  }
}

private struct TextInputFieldClearButtonHidden: EnvironmentKey {
  static var defaultValue: Bool = false
}

extension EnvironmentValues {
  var clearButtonHidden: Bool {
    get { self[TextInputFieldClearButtonHidden.self] }
    set { self[TextInputFieldClearButtonHidden.self] = newValue }
  }
}

// MARK: - Mandatory Field

extension View {
  public func isMandatory(_ value: Bool = true) -> some View {
    environment(\.isMandatory, value)
  }
}

private struct TextInputFieldMandatory: EnvironmentKey {
  static var defaultValue: Bool = false
}

extension EnvironmentValues {
  var isMandatory: Bool {
    get { self[TextInputFieldMandatory.self] }
    set { self[TextInputFieldMandatory.self] = newValue }
  }
}

// MARK: - Validation Handler

public struct ValidationError: Error {
  let message: String
  
  public init(message: String) {
    self.message = message
  }
}

extension ValidationError: LocalizedError {
  public var errorDescription: String? {
    return NSLocalizedString("\(message)", comment: "Message for generic validation errors.")
  }
}

private struct TextInputFieldValidationHandler: EnvironmentKey {
  static var defaultValue: ((String) -> Result<Bool, ValidationError>)?
}

extension EnvironmentValues {
  var validationHandler: ((String) -> Result<Bool, ValidationError>)? {
    get { self[TextInputFieldValidationHandler.self] }
    set { self[TextInputFieldValidationHandler.self] = newValue }
  }
}

extension View {
  public func onValidate(validationHandler: @escaping (String) -> Result<Bool, ValidationError>) -> some View {
    environment(\.validationHandler, validationHandler)
  }
}

// MARK: - Component Library

@available(iOS 14.0, *)
public struct TextInputField_Library: LibraryContentProvider {
  public var views: [LibraryItem] {
    [LibraryItem(TextInputField("First Name", text: .constant("Peter")),
                 title: "TextInputField",
                 category: .control)]
  }

  public func modifiers(base: TextInputField) -> [LibraryItem] {
    [LibraryItem(base.clearButtonHidden(true), category: .control)]
  }
}

// MARK: - Previews

struct TextInputField_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TextInputField("First Name", text: .constant("Bowerick Wowbagger the Infinitely Prolonged from outer space"))
        .clearButtonHidden()
        .previewLayout(.sizeThatFits)
      TextInputField("First Name", text: .constant("Peter"))
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
  }
}
