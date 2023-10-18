/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Picto : Codable {
	let id : String?
	let mimetype : String?
	let height : Int?
	let width : Int?
	let filename : String?
	let thumbnail : Bool?
	let format : String?
	let color_summary : [String]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case mimetype = "mimetype"
		case height = "height"
		case width = "width"
		case filename = "filename"
		case thumbnail = "thumbnail"
		case format = "format"
		case color_summary = "color_summary"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		mimetype = try values.decodeIfPresent(String.self, forKey: .mimetype)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		filename = try values.decodeIfPresent(String.self, forKey: .filename)
		thumbnail = try values.decodeIfPresent(Bool.self, forKey: .thumbnail)
		format = try values.decodeIfPresent(String.self, forKey: .format)
		color_summary = try values.decodeIfPresent([String].self, forKey: .color_summary)
	}

}