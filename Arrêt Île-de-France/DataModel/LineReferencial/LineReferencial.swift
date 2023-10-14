

import Foundation
struct LineReferencial : Codable {
	let datasetid : String
	let recordid : String
	let fields : Fields
	let record_timestamp : String

	enum CodingKeys: String, CodingKey {

		case datasetid = "datasetid"
		case recordid = "recordid"
		case fields = "fields"
		case record_timestamp = "record_timestamp"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		datasetid = try values.decode(String.self, forKey: .datasetid)
		recordid = try values.decode(String.self, forKey: .recordid)
		fields = try values.decode(Fields.self, forKey: .fields)
		record_timestamp = try values.decode(String.self, forKey: .record_timestamp)
	}

}
