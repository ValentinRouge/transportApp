
import Foundation
struct Fields : Codable {
	let status : String?
	let operatorref : String?
	let colourprint_cmjn : String?
	let textcolourprint_hexa : String?
	let audiblesigns_available : String?
	let transportsubmode : String?
	let textcolourweb_hexa : String?
	let id_groupoflines : String?
	let name_line : String
	let shortname_groupoflines : String?
	let accessibility : String?
	let visualsigns_available : String?
	let networkname : String?
	let shortname_line : String?
	let privatecode : String?
	let id_line : String
	let picto : Picto?
	let operatorname : String?
	let colourweb_hexa : String?
	let valid_fromdate : String?
	let transportmode : String?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case operatorref = "operatorref"
		case colourprint_cmjn = "colourprint_cmjn"
		case textcolourprint_hexa = "textcolourprint_hexa"
		case audiblesigns_available = "audiblesigns_available"
		case transportsubmode = "transportsubmode"
		case textcolourweb_hexa = "textcolourweb_hexa"
		case id_groupoflines = "id_groupoflines"
		case name_line = "name_line"
		case shortname_groupoflines = "shortname_groupoflines"
		case accessibility = "accessibility"
		case visualsigns_available = "visualsigns_available"
		case networkname = "networkname"
		case shortname_line = "shortname_line"
		case privatecode = "privatecode"
		case id_line = "id_line"
		case picto = "picto"
		case operatorname = "operatorname"
		case colourweb_hexa = "colourweb_hexa"
		case valid_fromdate = "valid_fromdate"
		case transportmode = "transportmode"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		operatorref = try values.decodeIfPresent(String.self, forKey: .operatorref)
		colourprint_cmjn = try values.decodeIfPresent(String.self, forKey: .colourprint_cmjn)
		textcolourprint_hexa = try values.decodeIfPresent(String.self, forKey: .textcolourprint_hexa)
		audiblesigns_available = try values.decodeIfPresent(String.self, forKey: .audiblesigns_available)
		transportsubmode = try values.decodeIfPresent(String.self, forKey: .transportsubmode)
		textcolourweb_hexa = try values.decodeIfPresent(String.self, forKey: .textcolourweb_hexa)
		id_groupoflines = try values.decodeIfPresent(String.self, forKey: .id_groupoflines)
		name_line = try values.decode(String.self, forKey: .name_line)
		shortname_groupoflines = try values.decodeIfPresent(String.self, forKey: .shortname_groupoflines)
		accessibility = try values.decodeIfPresent(String.self, forKey: .accessibility)
		visualsigns_available = try values.decodeIfPresent(String.self, forKey: .visualsigns_available)
		networkname = try values.decodeIfPresent(String.self, forKey: .networkname)
		shortname_line = try values.decodeIfPresent(String.self, forKey: .shortname_line)
		privatecode = try values.decodeIfPresent(String.self, forKey: .privatecode)
		id_line = try values.decode(String.self, forKey: .id_line)
		picto = try values.decodeIfPresent(Picto.self, forKey: .picto)
		operatorname = try values.decodeIfPresent(String.self, forKey: .operatorname)
		colourweb_hexa = try values.decodeIfPresent(String.self, forKey: .colourweb_hexa)
		valid_fromdate = try values.decodeIfPresent(String.self, forKey: .valid_fromdate)
		transportmode = try values.decodeIfPresent(String.self, forKey: .transportmode)
	}

}
