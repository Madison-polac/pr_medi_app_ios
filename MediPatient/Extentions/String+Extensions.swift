import UIKit

func LocalizedString(message : String) -> String {
    return NSLocalizedString(message, comment: "")
}

extension Double {
    var currencyValue : String {
        let formatter = NumberFormatter()
//        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return "\(formattedTipAmount)"
        }
        return "$0.00"
    }
}

extension Int{
    var hoursValue : String {
        
        return "\(self) hours"
    }
}

extension Double{
    var hoursValue : String {
        
        return "\(self) hours"
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    
    func compareVersions(webVersion: String) -> Bool {
        let v1 = self.components(separatedBy: ".")
        let v2 = webVersion.components(separatedBy: ".")
        
        var index = 0
        while (index < v1.count || index < v2.count) {
            var value1: Int = 0
            var value2: Int = 0
            if (index < v1.count) {
                value1 = Int(v1[index])!
            }
            
            if (index < v2.count) {
                value2 = Int(v2[index])!
            }

            index = index + 1

            if (value1 == value2) {
                continue
            } else {
                if (value1 > value2) {
                    return true
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    // Localization of the string
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func convertStringToArray(text: String) -> [[String: Any]]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
   
    var trim : String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var currencyValue : String {
        let formatter = NumberFormatter()
//        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale    
        formatter.numberStyle = .currency
        let currencyDouble  = Double(self) ?? 0.0
        if let formattedTipAmount = formatter.string(from: currencyDouble as NSNumber) {
            return "\(formattedTipAmount)"
        }
        return "$0.00"
    }
    
    var jsonStringRedecoded: String? {
        
        let dataa   : NSData = self.data(using: String.Encoding.utf8,allowLossyConversion: true)! as NSData
        let valueEmoj : String = String(data: dataa as Data, encoding: String.Encoding.nonLossyASCII) ?? ""
        return valueEmoj;
    }
    
    func dateString(ofFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ofFormat;
        return dateFormatter.date(from: self) ?? Date()
    }
    
    static func getJsonString(object: Any) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            return jsonString! as String
        } catch {
            return ""
        }
    }
  
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes:[.font : font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    
//    var htmlToAttributedString: NSAttributedString? {
//        let stringWithLineBreak = self.replacingOccurrences(of: "\n", with: "<br>", options: .literal, range: nil)
//
//        let attrStr = try! NSAttributedString(
//            data: (stringWithLineBreak.data(using: String.Encoding.unicode, allowLossyConversion: true)!),
//            options: [.documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil)
//        return attrStr
//    }
//
//    var htmlToString: String {
//        return htmlToAttributedString?.string ?? ""
//    }
    
    var htmlToAttributedString: NSAttributedString? {
//        let formatString = "<!DOCTYPE html><html><body><h1>This is heading 1</h1><h2>This is heading 2</h2></body></html>"
//        let formatString = "<!DOCTYPE html><html> \(self) <!html>"
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
//    subscript (r: Range<Int>) -> String {
//        let start = index(startIndex, offsetBy: r.lowerBound)
//        let end = index(startIndex, offsetBy: r.upperBound)
//        return String(self[Range(start ..< end)])
//    }
    
    var containsAlphabets: Bool {
        //Checks if all the characters inside the string are alphabets
        let set = CharacterSet.letters
        return self.utf16.contains {
            guard let unicode = UnicodeScalar($0) else { return false }
            return set.contains(unicode)
        }
    }
}

// MARK: - NSAttributedString extensions
public extension String {
    
    /// Regular string.
    var regular: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Bold string.
    var bold: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Underlined string
    var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// Strikethrough string.
    var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    /// Italic string.
    var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
}

extension Array where Element: NSAttributedString {
    func joined(separator: NSAttributedString) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    func joined(separator: String) -> NSAttributedString {
        return joined(separator: NSAttributedString(string: separator))
    }
}
