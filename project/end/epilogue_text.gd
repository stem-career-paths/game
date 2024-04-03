class_name EpilogueText extends RefCounted

enum Type {
	PARAGRAPH,
	MAIN_POINT
}

var text : String
var type : Type


static func create_paragraph(paragraph:String) -> EpilogueText:
	var result := EpilogueText.new()
	result.text = paragraph
	result.type = Type.PARAGRAPH
	return result


static func create_main_point(string:String) -> EpilogueText:
	var result := EpilogueText.new()
	result.text = string

	result.type = Type.MAIN_POINT
	return result
