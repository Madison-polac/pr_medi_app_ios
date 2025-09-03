
import Foundation
import ObjectMapper

struct User : Mappable {
	var patientNumber : String?
	var patientIdEnc : String?
	var patientDetailsForLinkIdEnc : String?
	var patientProfileToken : String?
	var jwtToken : String?
	var refreshToken : String?
	var expiration : String?
	var userName : String?
	var permissions : String?
	var statusCode : Int?
	var profilePhoto : String?
	var userIdEnc : String?
	var userTypeId : Int?
	var userTypeIdEnc : String?
	var isProfileCompleted : Bool?
	var isAccessPlatform : Bool?
	var subscriptionId : String?
	var subscriptionExpirationDate : String?
	var timezoneId : Int?
	var moduleNotifications : String?
	var roleId : Int?
	var lastPortalId : Int?
	var hasManagedCareAccess : Bool?
	var hasAITranscriptionAccess : Bool?
	var isSubscribed : Bool?
	var needPasswordReset : Bool?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		patientNumber <- map["patientNumber"]
		patientIdEnc <- map["patientIdEnc"]
		patientDetailsForLinkIdEnc <- map["patientDetailsForLinkIdEnc"]
		patientProfileToken <- map["patientProfileToken"]
		jwtToken <- map["jwtToken"]
		refreshToken <- map["refreshToken"]
		expiration <- map["expiration"]
		userName <- map["userName"]
		permissions <- map["permissions"]
		statusCode <- map["statusCode"]
		profilePhoto <- map["profilePhoto"]
		userIdEnc <- map["userIdEnc"]
		userTypeId <- map["userTypeId"]
		userTypeIdEnc <- map["userTypeIdEnc"]
		isProfileCompleted <- map["isProfileCompleted"]
		isAccessPlatform <- map["isAccessPlatform"]
		subscriptionId <- map["subscriptionId"]
		subscriptionExpirationDate <- map["subscriptionExpirationDate"]
		timezoneId <- map["timezoneId"]
		moduleNotifications <- map["moduleNotifications"]
		roleId <- map["roleId"]
		lastPortalId <- map["lastPortalId"]
		hasManagedCareAccess <- map["hasManagedCareAccess"]
		hasAITranscriptionAccess <- map["hasAITranscriptionAccess"]
		isSubscribed <- map["isSubscribed"]
		needPasswordReset <- map["needPasswordReset"]
	}

}
