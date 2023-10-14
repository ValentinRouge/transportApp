/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ZoneFields : Codable {
	let zdapostalregion : String
	let zdatype : String
	let zdaversion : String
	let zdayepsg2154 : Int
	let zdatown : String
	let zdacreated : String
	let zdcid : String
	let zdachanged : String
    let zdaname : String
	let zdaxepsg2154 : Int
	let zdaid : String

	enum CodingKeys: String, CodingKey {

		case zdapostalregion = "zdapostalregion"
		case zdatype = "zdatype"
		case zdaversion = "zdaversion"
		case zdayepsg2154 = "zdayepsg2154"
		case zdatown = "zdatown"
		case zdacreated = "zdacreated"
		case zdcid = "zdcid"
		case zdachanged = "zdachanged"
		case zdaname = "zdaname"
		case zdaxepsg2154 = "zdaxepsg2154"
		case zdaid = "zdaid"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		zdapostalregion = try values.decode(String.self, forKey: .zdapostalregion)
		zdatype = try values.decode(String.self, forKey: .zdatype)
		zdaversion = try values.decode(String.self, forKey: .zdaversion)
		zdayepsg2154 = try values.decode(Int.self, forKey: .zdayepsg2154)
		zdatown = try values.decode(String.self, forKey: .zdatown)
		zdacreated = try values.decode(String.self, forKey: .zdacreated)
		zdcid = try values.decode(String.self, forKey: .zdcid)
		zdachanged = try values.decode(String.self, forKey: .zdachanged)
		zdaname = try values.decode(String.self, forKey: .zdaname)
		zdaxepsg2154 = try values.decode(Int.self, forKey: .zdaxepsg2154)
		zdaid = try values.decode(String.self, forKey: .zdaid)
	}

}
